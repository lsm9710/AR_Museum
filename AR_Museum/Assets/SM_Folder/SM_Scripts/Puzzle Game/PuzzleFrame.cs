using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//퍼즐 틀의 최상위 부모가 갖게될 스크립트
public class PuzzleFrame : MonoBehaviour
{
    public GameObject succesCanvas;

    public float showUIdelay = 1f;
    bool isSucces = false;
    //나의 차일드 들을 리스트에 담아 관리하고 싶다.
    //차일드를 관리하기위해 담을 리스트
    public List<GameObject> puzzleFrameList = new List<GameObject>();

    //차일드들이 퍼즐이 끼워졌는지 감지하기 위한 리스트
    public List<Transform> checkMyChildChild = new List<Transform>();

    // Start is called before the first frame update
    void Start()
    {
        //나의 모든 차일드를 리스트에 담겠다.
        for (int i = 0; i < transform.childCount; i++)
        {
            PuzzleFramePiece puzzleScripts = transform.GetChild(i).gameObject.GetComponent<PuzzleFramePiece>();
            puzzleScripts.myID = i;
            puzzleFrameList.Add(transform.GetChild(i).gameObject);
            checkMyChildChild.Add(transform.GetChild(i).transform);
        }
    }

    // Update is called once per frame
    void Update()
    {
        //모든 차일드의 카운트가 각각 0보다 크다면 성공시키고 싶다.
        //모든 차일드의 카운트를 검사하려면 포문을 써야하는데 그러면 유니티가 뻗을걸
        //그럼 어떡해? 마지막에 맞춰진 조각이 신호룰 주도록 해볼까?
        //그건 어떻게 체크할건데??
        //부모인 내가 리스트를 가지고 있고, 자식들이 각각 퍼즐이 끼워질때마다 자신을 부모의 리스트에서 지우는거야
        //리스트에 길이가 전부 0이되면 그때부터 뭔가 이벤트를 실행하는거지
        //그럴듯한데??
        //한번 해보자
        if (checkMyChildChild.Count == 0 && isSucces == false)
        {
            StartCoroutine(SuccessSequence());
        }
    }
    IEnumerator SuccessSequence()
    {
        yield return new WaitForSeconds(showUIdelay);
        //성공했다는걸 보여주고싶다.
        succesCanvas.SetActive(true);
        isSucces = true;
    }
}
