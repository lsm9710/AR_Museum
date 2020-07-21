using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class APPTutorial : MonoBehaviour
{
    //튜토리얼은 앱을 설치했을때 한번만 보이고 싶다
    //튜토리얼을 한번 다 봤다면 더는 보이지 않고 싶다.
    //아직 한번도 보지 않았다면 앱을 실행할때 튜토리얼 캔버스를 켜주고
    //이미 한번 봤다면 앱을 실행할때 튜토리얼 캔버스를 꺼버리자.
    [SerializeField]
    int accumulate;
    bool IhaveSeenBefore;

     //string accumulatePoint ;

    public static APPTutorial instance;

    public float amount;

    GameObject tutorialCanvas;

    public int AccumulatePoint
    {
        get
        {
            return accumulate;
        }
        set
        {
            accumulate = value;
            //튜토리얼을 본 횟수가 0보다 크면
            if (accumulate > 0 && !IhaveSeenBefore)
            {
                //꺼버려
                StartCoroutine(TurnOffTheCanvas());
                //저장을 하자
                PlayerPrefs.SetInt("ACCPOINTT", accumulate);
                IhaveSeenBefore = true;
            }
            //튜토를 본 횟수가 0보다 작을때만
            else if (accumulate < 0)
            {
                //켜줘
                tutorialCanvas.SetActive(true);
            }
        }
    }
    private void Awake()
    {
        instance = this;
    }
    // Start is called before the first frame update
    void Start()
    {
        tutorialCanvas = transform.Find("Tutorial Canvas").gameObject;
        AccumulatePoint = PlayerPrefs.GetInt("ACCPOINTT", 0);
        if (IhaveSeenBefore) tutorialCanvas.SetActive(false);
    }

    IEnumerator TurnOffTheCanvas()
    {
        yield return new WaitForSeconds(amount);
        tutorialCanvas.SetActive(false);
    }
}
