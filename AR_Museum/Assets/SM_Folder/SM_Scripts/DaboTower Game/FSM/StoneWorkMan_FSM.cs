using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StoneWorkMan_FSM : MonoBehaviour
{
    //State가 필요하다.
    public enum StoneWorkMan
    {
        Idle,                   //사용자의 터치 전 아이들 하고 있는 상태
        Move_To_DoboTower,      //다보탑을 향해 달려가는 상태
        Spread,                 //자기자리를 찾아서 산개하는 상태
        Hammering,              //망치질하는 상태
        Success,                //게임에 성공했을때
        Fail                    //실패했을때
    }

    public StoneWorkMan state;
    Animator anim;

    public GameObject daboTower;
    public float moveSpeed;
    public float rotSpeed;
    public float graceDistance;

    Vector3 dirForDaboTower;

    [SerializeField]
    Transform target;

    private float[] successValuePool = { 0.01f, 0.33f, 0.66f };
    private float[] valuePool = { 0.01f, 0.25f, 0.5f, 0.75f, 1f };

    int value;
    int successValue;

    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animator>();
        //시작할때 블렌드 트리에서 할 애니메이션의 값을 구해주자
        successValue = Random.Range(0, successValuePool.Length);
        value = Random.Range(0, valuePool.Length);
        //시작할때 Idle로 보내서 인사를 시키자
        AnimChangeState(StoneWorkMan.Idle);
    }

    // Update is called once per frame
    void Update()
    {
        SwitchState();
    }

    void SwitchState()
    {
            if (WK_DabotopGame.succeseBool) AnimChangeState(StoneWorkMan.Success);
            if (WK_DabotopGame.failBool) AnimChangeState(StoneWorkMan.Fail);
        switch (state)
        {
            case StoneWorkMan.Idle:
                Idle();
                break;
            case StoneWorkMan.Move_To_DoboTower:
                Move_To_DoboTower(daboTower.transform.position, transform.position);
                break;
            case StoneWorkMan.Spread:
                Spread();
                break;
            case StoneWorkMan.Hammering:
                Hammering();
                break;
        }
    }

    void AnimChangeState(StoneWorkMan swm)
    {
        state = swm;
        switch (swm)
        {
            case StoneWorkMan.Idle:
                anim.SetFloat("Idle", valuePool[value]);
                break;
            case StoneWorkMan.Move_To_DoboTower:
                anim.SetTrigger("Lest's Do this");
                break;
            //case StoneWorkMan.Spread:
            //    anim.SetTrigger("Lest's Do this");
            //    break;
            case StoneWorkMan.Hammering:
                anim.SetTrigger("Hammering");
                break;
            case StoneWorkMan.Success:
                anim.SetFloat("Success", successValuePool[successValue]);
                //gameSet = false;
                break;
            case StoneWorkMan.Fail:
                anim.SetFloat("Defeat", valuePool[value]);
                //gameSet = false;
                break;
        }
    }

    private void Idle()
    {
        //사용자의 터치가 있기 전에는 인사를 하거나 아이들 하는 상태로 있다가
        //사용자의 터치가 시작되면 다보탑을 향해 달려간다(Move1 필요)
        if (WK_DabotopGame.isStart) AnimChangeState(StoneWorkMan.Move_To_DoboTower);
    }

    private void Move_To_DoboTower(Vector3 x, Vector3 y)
    {
        //다보탑을 향해 달려가면서, 다보탑과 나와의 거리를 계속 비교한다.
        //거리는 구했고
        float dist = Vector3.Distance(x, y);
        //회전을 해보자
        //각도를 구해서
        //float angle = Vector3.SignedAngle(transform.forward, daboTower.transform.position, -transform.forward);
        //print("angle : " + angle);
        ////각도가 일정수준보다 높다면
        //if (angle > 0.2f)
        //{
        //    //회전하고
        //    dirForDaboTower.y = 0;
        //}
        //else
        //{
        //}
        dirForDaboTower = daboTower.transform.position - gameObject.transform.position;
        dirForDaboTower.y = 0f;
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dirForDaboTower), rotSpeed * Time.deltaTime);
        //그게 아니라면
        //다보탑과의 거리가 지정해준 거리보다 멀 경우에 이동해라
        if (dist >= graceDistance) transform.position += dirForDaboTower.normalized * moveSpeed * Time.deltaTime;
        // 대신 다보탑과 나와의 거리가 일정 이상 가까워지면 각자위치로 산개한다.
        else if (dist < graceDistance) AnimChangeState(StoneWorkMan.Spread);
    }

    int GetWorkPosionIdx()
    {
        int idx = -1;
        int y = 0;
        float min = float.MaxValue;

        for (y = 0; y < WorkPositon_Manager.WP.workPosition.Count; y++)
        {
            //각 인덱스들의 거리값을 구해서
            float dist = Vector3.Distance(transform.position, WorkPositon_Manager.WP.workPosition[y].transform.position);
            //flot만 들어가는 리스트에 따로 넣고

            //걔들중에 최솟값을 구해서
            if (min > dist)
            {
                min = dist;
                //밖으로 인덱스 값을 갖고나갈 int 변수에 할당
                idx = y;
            }
        }
        return idx;
    }

    Vector3 GetDir(Vector3 p1, Vector3 p2, out float dis)
    {
        Vector3 rv = (p1 - p2);
        dis = Vector3.Distance(p1, p2);
        return rv;
    }

    private void Spread()
    {
        //나와 가장 가깝고, 차일드 카운트가 0 인 포인트를 향해서 이동하고싶다.
        //차일드 카운트다 1이 된 포지션은 자동으로 리스트에서 지우도록 하자

        int idx = GetWorkPosionIdx();
        //타겟을 정해준다.
        if (idx == -1) return;

        target = WorkPositon_Manager.WP.workPosition[idx].gameObject.transform;
        //방향을 가장 가깝다고 한 녀석으로 정하고
        //Vector3 dir = target.position - transform.position;
        float distance = 0.0f;
        Vector3 dir = GetDir(target.position, transform.position, out distance);
        dir.y = 0;

        //그쪽을 향해서 회전해
        transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dir), rotSpeed * Time.deltaTime);

        //해당 포인트와 일정이상 가까워지면 나의 부모를 해당 포인트로 하고
        //이동해 
        if (distance > amount) transform.position += dir.normalized * moveSpeed * Time.deltaTime;

        else if (distance <= amount)
        {
            //만약 타겟의 차일드 카운트가 0이라면
            if (target.childCount <= 0)
            {
                //타워를 향해 회전하고 싶다.
                //다보탑을 향해서 회전하고 싶다.
                dirForDaboTower = daboTower.transform.position - transform.position;
                transform.forward = dirForDaboTower.normalized;
                transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.LookRotation(dirForDaboTower.normalized), rotSpeed * Time.deltaTime);
                float angle = Vector3.SignedAngle(transform.forward, daboTower.transform.position, transform.position);
                //print(transform.name + " + " + angle);
                ////다보탑을 바라보고 섰다면 망치질을 시작하고 싶다.
                if (angle < 0.1f)
                {
                    transform.SetParent(target);
                    AnimChangeState(StoneWorkMan.Hammering);
                }
                else return;
            }
            //차일드 카운트가 0보다 크다면
                //처음부터 다시해
            else if (target.childCount > 0) state = StoneWorkMan.Spread;
        }
    }
    public float amount;

    public GameObject hammer;
    private void Hammering()
    {
        hammer.SetActive(true);
        //망치질 하는 애니메이션을 시작하고
        anim.SetTrigger("Hammering");
        //이펙트 에셋은 애니메이션 클립에서 이벤트로 호출 하겠다.
    }

    [SerializeField]
    public ParticleSystem pong;
    void Event_Hammering()
    {
        pong.transform.gameObject.SetActive(true);
        pong.Play();
    }
}
