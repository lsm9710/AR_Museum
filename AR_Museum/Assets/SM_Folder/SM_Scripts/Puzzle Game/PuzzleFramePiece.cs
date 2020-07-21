using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PuzzleFramePiece : MonoBehaviour
{
    public int myID;

    GameObject myChild;

    public float detectionRange = 0.8f*100;

    float dis;

    public bool isEnter = false;

    //내가 직접 충돌체를 감지할거다.
    private void OnTriggerStay(Collider other)
    {
        //충돌체한테서 그녀석의 ID를 가져온다.
        SM_Puzzle sm_puzzle = other.transform.GetComponent<SM_Puzzle>();
        //충돌체의 ID랑 내 ID가 일치하면 아래내용을 실행하겠다.
        if (sm_puzzle != null && sm_puzzle.myID == myID)
        {
            isEnter = true;
            //충돌체와 나와의 거리를 비교한다.
            Vector3 pos = other.gameObject.transform.parent.transform.position + other.gameObject.transform.localPosition;
            dis = Vector3.Distance(gameObject.transform.position,pos);
            
            Debug.Log(gameObject.name + "+" +other.gameObject.name + "dis --> " + dis);

            //일정 범위 이상 가까워진 상태에서
            if (dis <= detectionRange && dis >= 0f)
            {
                //사용자가 버튼에서 손을 떼면
                if (Input.GetMouseButtonUp(0) && isEnter)
                {
                    SM_ARManager.instance.OnMouseButtonUp();
                    //충돌체의 부모에게서 List를 받아와서 충돌체를 리스트에서 삭제
                    SM_Puzzle_Parent pp = other.transform.parent.GetComponent<SM_Puzzle_Parent>();
                    pp.puzzleList.Remove(other.gameObject);

                    //충돌체를 부모에게서 분리해서 내 자식으로 빼앗겠다.
                    other.transform.SetParent(gameObject.transform);

                    myChild = other.gameObject;
                    //if (dis <= youAreMinRange/* && dis <= youAreMinRange + 0.01f*/)
                    //{
                    //그냥 내 위치랑 똑같게 해
                    myChild.transform.localPosition = new Vector3(0, -10f, 0); ;
                    myChild.GetComponent<BoxCollider>().enabled = false;
                    transform.GetComponent<BoxCollider>().enabled = false;

                    //그리고 내 부모의 자식체크 리스트에서 날 빼줘
                    PuzzleFrame pf = transform.parent.GetComponent<PuzzleFrame>();
                    pf.checkMyChildChild.Remove(transform);
                    //}
                }
            }
        }
        //충돌체와 나의 ID가 일치하지 않는다면?
        else
        {
            //불값을 초기화
            isEnter = false;
        }
    }

    private void Update()
    {
        ////내 자식의 숫자가 0보다 커지면
        //if (transform.childCount > 0)
        //{
        //    //점점빨라지는 속도를 구하고
        //    fMove = (Time.deltaTime * Speed); //Speed = 0.5f
        //    //충돌체를 내 위치까지 서서히 가져와서
        //    myChild.transform.position = Vector3.Lerp(gameObject.transform.position, myChild.gameObject.transform.position, fMove);
        //    //일정 이상 가까워지면
            
        //}
    }
}
