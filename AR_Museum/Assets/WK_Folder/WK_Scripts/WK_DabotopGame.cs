using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
//목표: 한번씩 탭을 하면 오브젝트가 생성 되는 것이 보인다

public class WK_DabotopGame : MonoBehaviour
{
    //다보탑 전체 조각 갯수
    public int dabotopPiceCount = 117;

    //다보탑 조각들을 담을 배열 
    public GameObject[] dabotops;

    //탭할 때 마다 저장 될 탭 카운트
    int showIdx = 0;

    //아사녀 UI Value
    public GameObject siderBar;
    Slider asaGirl_slideValue;
    public float asaGirl_Speed = 0.1f;

    public int amount;

    int tapCount =0;

    bool ready = false;

    [HideInInspector]
    public static bool succeseBool = false;
    //[HideInInspector]
    public static bool failBool = false;
    [HideInInspector]
    public static bool isStart = false;

    public GameObject succsecUI;
    public GameObject failUI;

    

    // 게임 시작할 때 먼저 다보탑의 조각들을 다보탑 조각 배열에 넣자
    void Start()
    {
        dabotops = new GameObject[dabotopPiceCount];

        FindToAdd();

        //UI의 슬라이더 Value를 찾아오기
        //asaGirl_slideValue.value = GameObject.Find("Canvas_DaboGame/Slider").GetComponent<Slider>().value;
        asaGirl_slideValue = siderBar.GetComponent<Slider>();
        //카운트 다운을 하고 카운트 다운이 끝나면 터치가 먹도록 하고싶다.
        StartCoroutine(CountDown());
    }

    IEnumerator CountDown()
    {
        isStart = true;
        yield return new WaitForSeconds(1);
        print("3");
        yield return new WaitForSeconds(1);
        print("2");
        yield return new WaitForSeconds(1);
        print("1");
        yield return new WaitForSeconds(1);
        print("start!!");
        ready = true;
    }

    void Update()
    {
        //게임 스타트가 떨어졌을때 아래내용을 실행하고싶다.
        if (ready == true)
        {
            //게임 시작
            TouchGamePlay();

            //아사녀 타임 슬라이더
            UI_AsaGirlSlidebar();
        }
        //만약 마지막 다보탑 부품이 켜졌다면
        if (dabotops[dabotopPiceCount-1].activeSelf == true)
        {
            //시간을 멈추고 터치도 막겠다
            ready = false;
            //모든 인부들에게 환호성 스테이트를 명령하겠다.
            succeseBool = true;
            //성공시퀀스 실행
            StartCoroutine(Succse());
        }
    }

    IEnumerator Succse()
    {
        yield return new WaitForSeconds(1.5f);
        //성공UI를 띄우겠다
        succsecUI.SetActive(true);
    }

    void FindToAdd()
    {
        for (int i = 0; i < dabotops.Length; i++)
        {
            //"Da1~Da116"이름을 가진 오브젝트를 찾아 순차적으로 배열에 넣는다
            dabotops[i] = GameObject.Find("Da" + i.ToString());

            //배열의 오브젝트를 모두 보이지 않게 한다.
            dabotops[i].SetActive(false);
        }
        //단, 0번째(바닥판) 오브젝트만 게임 시작하기 전에 보이게 한다.
        dabotops[0].SetActive(true);
    }

    void TouchGamePlay()
    {
        //화면을 터치 할 때 마다 디스카운트되면서 다보탑 오브젝트의 배열에서 오브젝트를 하나씩 활성화 시켜 보이게 한다
        if (Input.GetMouseButtonDown(0))
        {
            tapCount += 1;
            if(tapCount >= amount)
            {
                showIdx += 1;
                tapCount = 0;
            }
            if (showIdx < dabotopPiceCount)  dabotops[showIdx].SetActive(true);
        }
        else return;
    }

    void UI_AsaGirlSlidebar()
    {
        //슬라이더 밸류가 아직 남아있다면 시간을 가게 하고
        if (asaGirl_slideValue.value != 1) asaGirl_slideValue.value+= Time.deltaTime / asaGirl_Speed;
        //만약 슬라이더 밸류가 1이 될때까지 마지막 다보탑 부품이 켜지지 않았다면
        if(asaGirl_slideValue.value == 100)
        {
            ready = false;
            failBool = true;
            print(failBool);
            //게임오버 UI를 띄우겠다.
            failUI.SetActive(true);
        }
    }

    //게임 다시하기
     void ReStartGame()
    {
        //카운트 초기화
        showIdx = 0;

        //모든 다보탑조각들 안보이게 초기화
        dabotops = new GameObject[dabotopPiceCount];

        for (int i = 0; i < dabotops.Length; i++)
        {
            dabotops[i] = GameObject.Find("Da" + i.ToString());
            dabotops[i].SetActive(false);
        }
        dabotops[0].SetActive(true);
    }
}


