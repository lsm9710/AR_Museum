using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class wook_STAMP_Manager : MonoBehaviour
{
    public GameObject ARcamBtn;
    public GameObject GalleryBtn;

    //도장 배열
    public GameObject[] stampCheck;
    //불배열
    public bool[] GameCheck = {false,false,false };

    public static wook_STAMP_Manager instance;
    int count = 0;

    public int SuccessCount = 0;

    public bool ischecked = false;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
    }

    // Start is called before the first frame update
    void Start()
    {       
        DontDestroyOnLoad(gameObject);
    }

    // Update is called once per frame
    void Update()
    {
        if(!ischecked) StampCheck();
    }

    //현재 나의 성공카운트를 체크하는 함수
    public void StampCheck()
    {
        if (SceneManager.GetActiveScene().name == "Rally_Main_Scene")
        {
            stampCheck = GameObject.FindGameObjectsWithTag("SuccessCircle");
            for (int i = 0; i < GameCheck.Length; i++)
            {
                if (GameCheck[i] == true)
                {
                    stampCheck[i].GetComponent<Image>().enabled = true;
                }
            }
        }





            ////불 배열의 참 / 거짓에 따라 아래 내용을 실행하고싶다.
            //for (int y = 0; y < GameCheck.Length; y++)
            //{
            //    //성공카운트가 0보다 클때
            //    //현재 씬이 메인씬이라면
            //    if (GameCheck[y] && SceneManager.GetActiveScene().name == "Rally_Main_Scene")
            //    {
            //        //동글뱅이들을 찾겠다
            //        stampCheck = GameObject.FindGameObjectsWithTag("SuccessCircle");
            //        //성공 카운트의 갯수에 따라서 stampCheck의 이미지를 켜고 싶다
            //        for (int i = 0; i < SuccessCount; i++)
            //        {
            //            stampCheck[i].GetComponent<Image>().enabled = true;
            //        }
            //        //if문이 한번만 타도록 해줄 불 변수
            //        ischecked = true;
            //    }
            //    else return;
            //}
    }


    public void StampCheckModule(int i)
    {


        stampCheck[i].SetActive(true);
        /* i 세팅
         * 씨름 = 0
         * 대동여지도 =1
         * 다보탑 =2
         * 
         * case GameSceneState.Game_Ssileum:
              //틀린그림찾기 게임오브젝트가 나와야한다.
              GameObject ssileum = Instantiate(GSLP.game_Object[0]);
              break;
          case GameSceneState.Game_Daedongyeojido:
              //대동여지전도 게임오브젝트가 나와야한다.
              GameObject daedongyeojido = Instantiate(GSLP.game_Object[1]);
              daedongyeojido.transform.position = Vector3.zero;
              break;
          case GameSceneState.Game_DaboTower:
              //다보탑은 스크립트를 켜줘야한다.
         */

        for (int j = 0; j < stampCheck.Length; j++)
        {
            if (stampCheck[j].activeSelf)
            {
                count++;
            }
        }
        if (count == stampCheck.Length)
        {
            print("완성");
            //모든 스탬프 모았을때 실행 하는 명령
            ARcamBtn.SetActive(true);
            GalleryBtn.SetActive(true);


        }
        else
        {
            count = 0;
        }

    }


}
