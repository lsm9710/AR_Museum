using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wook_Game_Different : MonoBehaviour
{
    public GameObject[] points;

    public GameObject sceneLoad;

    public int countTouch = 0;

    public GameObject startMsg;

    // Start is called before the first frame update
    void Start()
    {
      
    }

    // Update is called once per frame
    void Update()
    {
        for(int i =0; i<points.Length; i++)
        {
            if (points[i].GetComponent<wook_Touch>().correct)
                countTouch++;
        }
        if (countTouch >= 6)
        {

//6개 다찾고 게임 성공시 로드
            sceneLoad.SetActive(true);

            //wook_STAMP_Manager.instance.StampCheckModule(0);
            wook_STAMP_Manager.instance.GameCheck[0] = true;
        }
        else
            countTouch = 0;


    }
}
