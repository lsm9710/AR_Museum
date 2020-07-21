using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SM_Puzzle_Parent : MonoBehaviour
{
    //퍼즐을 담을 리스트
    public List<GameObject> puzzleList = new List<GameObject>();
    // Start is called before the first frame update
    void Start()
    {
        //나의 모든 차일드를 리스트에 담겠다.
        for (int i = 0; i < transform.childCount; i++)
        {
            //퍼즐 조각들이 가지고 있는 ID를 인덱스 번호에 맞춘다.
            SM_Puzzle puzzleScripts = transform.GetChild(i).gameObject.GetComponent<SM_Puzzle>();
            puzzleScripts.myID = i;
            puzzleList.Add(transform.GetChild(i).gameObject);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
