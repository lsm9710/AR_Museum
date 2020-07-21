using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Animations;

public class WorkMan_FSM : MonoBehaviour
{
    //State가 필요하다
    public enum WorkMan
    {
        Startstate,
        Idle,               //사용자의 입력 전까지 아이들 하고 있는 상태
        Move_To_Quarry,     //채석장을 향해 달려가는 상태
        Spread,             //빈자리를 찾아 산개하는 상태
        Quarrying,          //채석하는 상태
        PickUP,             //돌을 들어올리는 상태
        CarryingPayload,    //돌을 든채 이동하는 상태
        PutDown,            //돌을 내려놓는 상태
        Success,            //게임에 성공했을때
        Fail,               //실패했을때
    }

    public WorkMan state;
    Animator anim;
    GameObject my_camera;


    //채석장
    public GameObject quarry;
    //이동속도
    public float moveSpeed;
    //회전속도
    public float rotSpeed;
    //ㅇ여유거리
    public float graceDistance;

    [SerializeField]
    Transform target;

    //채석장을 향하는 방향
    Vector3 dirForQuarry;
    //짐을 옮기는 지정포인트
    Vector3 dirForPutDownPoint;

    public GameObject stone;

    private float[] successValuePool = { 0.01f,0.33f, 0.66f };
    private float[] valuePool = { 0.01f, 0.25f, 0.5f, 0.75f, 1f };

    int value;
    int successValue;

    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
        dirForPutDownPoint = GameObject.FindGameObjectWithTag("PutDownPosition").transform.position;
        my_camera = GameObject.FindGameObjectWithTag("MainCamera");

        //시작할때 블렌드 트리에서 할 애니메이션의 값을 구해주자
        successValue = Random.Range(0, successValuePool.Length);
        value = Random.Range(0, valuePool.Length);
        //시작할때 Idle로 보내서 인사를 시키자
        AnimChangeState(WorkMan.Idle);
    }

    // Update is called once per frame
    void Update()
    {
        SwitchState();
    }

    void SwitchState()
    {
        //성공했을때 스테이트를 변경시켜줄 if문
        if (WK_DabotopGame.succeseBool) AnimChangeState(WorkMan.Success);
        //실패했을때 스테이트를 변경시켜줄 if문
        if (WK_DabotopGame.failBool) AnimChangeState(WorkMan.Fail);
        switch (state)
        {
            case WorkMan.Idle:
                Idle();
                break;
            case WorkMan.Move_To_Quarry:
                Move_To_Quarry(quarry.transform.position, transform.position);
                break;
            case WorkMan.Spread:
                Spread();
                break;
            case WorkMan.CarryingPayload:
                CarryingPayload(dirForPutDownPoint, transform.position);
                break;
            case WorkMan.Success:
                GameSetEvent(stone, pick);
                break;
            case WorkMan.Fail:
                GameSetEvent(stone, pick);
                break;
        }
    }

    void GameSetEvent(GameObject obj1, GameObject obj2)
    {
        if (obj1.activeSelf == true) obj1.SetActive(false);
        if (obj2.activeSelf == true) obj2.SetActive(false);

        //카메라를 향해 바라보고싶다.
        transform.LookAt(my_camera.transform.position);
    }

    public void AnimChangeState(WorkMan wm)
    {
        state = wm;
        switch (wm)
        {
            case WorkMan.Idle:
                anim.SetFloat("Idle", valuePool[value]);
                break;
            case WorkMan.Move_To_Quarry:
                anim.SetTrigger("Let's Do this");
                break;
            case WorkMan.Quarrying:
                anim.SetTrigger("Quarrying");
                break;
            case WorkMan.PickUP:
                anim.SetTrigger("PickUP");
                break;
            case WorkMan.CarryingPayload:
                anim.SetTrigger("CarryingPayload");
                break;
            case WorkMan.PutDown:
                anim.SetTrigger("PutDown");
                break;
            case WorkMan.Success:
                anim.SetFloat("Success", successValuePool[successValue]);
                break;
            case WorkMan.Fail:
                anim.SetFloat("Defeat", valuePool[value]);
                break;
        }
    }

    private void Idle()
    {
        //사용자의 입력이 있기 전까지는 인사하고있다가
        //사용자가 입력하면 채석장을 향해서 달려가고(Move1)
        if (WK_DabotopGame.isStart) AnimChangeState(WorkMan.Move_To_Quarry);
    }

    private void Move_To_Quarry(Vector3 x, Vector3 y)
    {
        //채석포인트에 일정이상 가까워지면
        float dist = Vector3.Distance(x, y);
        dirForQuarry = x - y;
        dirForQuarry.y = 0f;
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dirForQuarry), rotSpeed * Time.deltaTime);
        if (dist >= graceDistance) transform.position += dirForQuarry.normalized * moveSpeed * Time.deltaTime;
        //흩어져
        else if (dist < graceDistance) state = WorkMan.Spread;
    }

    int GetWorkPosIdx()
    {
        int idx = -1;
        //int a = 0;
        float min = float.MaxValue;

        for (int i = 0; i < WorkPositon_Manager.WP.quarryPosition.Count; i++)
        {
            //각 인덱스들의 거리값을 구해서
            float dist = Vector3.Distance(transform.position, WorkPositon_Manager.WP.quarryPosition[i].transform.position);
            //걔들중에 최솟값을 구해서
            //만약 float 최댓값보다 거리가 작다면
            if(min > dist)
            {
                //최솟값을 갱신하고
                min = dist;
                //밖으로 인덱스값을 갖고나갈 int 변수에 할당
                idx = i;
            }
        }
        return idx;
    }

    Vector3 GetDir(Vector3 p1, Vector3 p2, out float dis)
    {
        Vector3 rv = (p1 - p2);
        dis = Vector3.Distance(p1, p2);
        //print(dis);
        return rv;
    }

    //그 일정한 거리를 정해줄 float 변수
    public float amount;
    private void Spread()
    {
        //채석장을 향해 돌아서서
        //채석장이 어딨는데?
        int idx = GetWorkPosIdx();
        //만약에 타겟이 없으면 다시찾아
        if (idx == -1) return;

        //타겟을 정해준다
        target = WorkPositon_Manager.WP.quarryPosition[idx].gameObject.transform;

        //이렇게 하면 거리와 함께 방향도 알아낼 수 있지
        float distance = 0.0f;
        Vector3 dir = GetDir(target.position, transform.position, out distance);
        dir.y = 0;
        //해당 포인트랑 일정이상 가까워지면
        if (distance > amount)
        {
            transform.position += dir.normalized * moveSpeed * Time.deltaTime;
            //그쪽을 향해서 회전해
            transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dir), rotSpeed * Time.deltaTime);
        }
        else if (distance <= amount)
        {
            //해당포인트의 차일드 갯수를 비교해서
            //포인트에 아무도 없다면
            if (target.childCount <= 0)
            {
                //채석장을 향해 회전하고싶다
                dirForQuarry = dir;
                //transform.forward = dirForQuarry.normalized;
                transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(-quarry.transform.forward), rotSpeed * Time.deltaTime);
                float angle = Vector3.SignedAngle(transform.forward, quarry.transform.position, Vector3.up);
                //채석장을 바라고보 섰다면 곡괭이질을 시작해
                if (angle < 15f)
                {
                    PositionsSelf pself = target.GetComponent<PositionsSelf>();
                    pself.atOnce = true;
                    transform.SetParent(target);
                    AnimChangeState(WorkMan.Quarrying);
                }
            }
            else if (target.childCount > 0) state = WorkMan.Spread;
        }
    }

    private void CarryingPayload(Vector3 x, Vector3 y)
    {
        //Put Down point을 향해 달려간다(Move2)
        //Put Down point에 일정이상 가까워지면
        float dist = Vector3.Distance(x, y);
        Vector3 dir = x - y;
        dir.y = 0f;
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dir), rotSpeed * Time.deltaTime);
        if (dist >= 1) transform.position += dir.normalized * moveSpeed * Time.deltaTime;
        //흩어져
        else if (dist < 1) AnimChangeState(WorkMan.PutDown);
    }

    void Event_SpawnStone()
    {
        stone.SetActive(true);
    }

    void Event_DestroyStone()
    {
        stone.SetActive(false);
    }

    public GameObject pick;
    void Event_Quarrying()
    {
        //손에 곡괭이를 들리고 싶다.
        pick.SetActive(true);
    }

    //스테이트를 픽업으로 넘기고 싶어
    void Event_PickUP()
    {
        pick.SetActive(false);
        AnimChangeState(WorkMan.PickUP);
    }

    void Event_CarryingPayload()
    {
        transform.SetParent(GameObject.Find("WorkMans").transform);
        AnimChangeState(WorkMan.CarryingPayload);
    }
    void Event_GoBackYourPosition()
    {
        AnimChangeState(WorkMan.Move_To_Quarry);
    }
}
