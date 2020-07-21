using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR.ARFoundation;
using UnityEngine.UI;

[Serializable]
public class MainScene_ListPool
{
    //오디오를 저장 및 관리할 리스트
    public List<AudioClip> audioList = new List<AudioClip>();

    //메인씬에서 보일 오브젝트들을 관리할 리스트
    public List<GameObject> main_Object = new List<GameObject>();
}
[Serializable]
public class GameScene_ListPool
{
    //게임씬에서 보일 오브젝트들을 관리할 리스트
    public List<GameObject> game_Object = new List<GameObject>();
}

//오브젝트들을 분류해놓을 스테이트
public enum SceneState
{
    Main,
    Game,
    MarkerCamer,
    ARCamer,
    Scene_End
}

//메인씬에서 사용할 스테이트
public enum MainSceneState
{
    Ssileum,
    Daedongyeojido,
    DaboTower,
    Main_Over
}
//게임씬에서 사용할 스테이트
public enum GameSceneState
{
    Ssileum,
    Daedongyeojido,
    DaboTower,
    Game_Over
}
public class ObjManager : MonoBehaviour
{
    public static ObjManager instance;

    public SceneState sceneState;
    public MainSceneState state_Main;
    MainSceneState[] main_allState = new MainSceneState[(int)MainSceneState.Main_Over];
    public GameSceneState state_Game;
    GameSceneState[] game_allState = new GameSceneState[(int)GameSceneState.Game_Over];
    //===========================================
    [HideInInspector]
    public string imageName;

    //씬에 진입중인지 아닌지 판단해줄 불변수
    //[HideInInspector]
    public bool entering = false;

    //============================================

    //마커이미지 클래스를 받아올 변수
    public MakerImageInfo imagesInfo = new MakerImageInfo();

    //============================================

    public MainScene_ListPool MSLP;

    public GameScene_ListPool GSLP;

    //============================================
    [HideInInspector]
    public AudioClip audioClip;
    AudioSource audioSource;

    GameObject arOrigin;
    //Text debugText;

    private void Awake()
    {
        instance = this;
        DontDestroyOnLoad(gameObject);
    }

    private void OnEnable()
    {
        //현재 씬을 감지하는 함수
        DetectionCurrentScene();
    }
    private void Start()
    {
        InitState();

    }

    void InitState()
    {
        main_allState[0] = MainSceneState.Ssileum;
        main_allState[1] = MainSceneState.Daedongyeojido;
        main_allState[2] = MainSceneState.DaboTower;

        game_allState[0] = GameSceneState.Ssileum;
        game_allState[1] = GameSceneState.Daedongyeojido;
        game_allState[2] = GameSceneState.DaboTower;
    }
    //현재 씬을 감지해서 스테이트를 넘겨줄 함수
    public void DetectionCurrentScene()
    {
        if (SceneManager.GetActiveScene().name == "Rally_Main_Scene")
        {
            sceneState = SceneState.Main;
            //스크립트나 컴포넌트를 찾아오자
            audioSource = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<AudioSource>();
        }
        if (SceneManager.GetActiveScene().name == "Rally_GameScene")
        {
            sceneState = SceneState.Game;
        }
        if (SceneManager.GetActiveScene().name == "Rally_MarkerCameraScene")
        {
            sceneState = SceneState.MarkerCamer;
        }
        if (SceneManager.GetActiveScene().name == "Rally_FaceARScene")
        {
            sceneState = SceneState.ARCamer;
        }
    }

    public void Switch_WhatIsThisScene()
    {
        switch (sceneState)
        {
            case SceneState.Main:
                if (entering == false)
                {
                    WahtIsMyMaker_Main();
                    entering = true;
                }
                break;
            case SceneState.Game:
                if (entering == false)
                {
                    WhatISMyMarker_Game();
                    //debugText.text = "호올리 지져스";
                    entering = true;
                }
                break;
            case SceneState.MarkerCamer:
                //마커에 따른 스테이트 초기화
                 main_allState = new MainSceneState[(int)MainSceneState.Main_Over];
                game_allState = new GameSceneState[(int)GameSceneState.Game_Over];
                InitState();


                break;
            case SceneState.ARCamer:
                //마커에 따른 스테이트 초기화
                main_allState = new MainSceneState[(int)MainSceneState.Main_Over];
                game_allState = new GameSceneState[(int)GameSceneState.Game_Over];
                InitState();
                break;
        }
    }

    //메인씬에서 마커를 검사할 함수
    private void WahtIsMyMaker_Main()
    {
        //마커 이름에 따라 스테이트를 바꾸고 싶다.
        for (int i = 0; i < main_allState.Length; i++)
        {

            if (imageName == main_allState[i].ToString())
            {
                state_Main = main_allState[i];
                Switch_Main();
                break;
            }
        }
    }
    //게임씬에서 마커를 검사할 함수
    private void WhatISMyMarker_Game()
    {
        //마커의 이름에 따라 스테이트를 바꾸고싶다.
        for (int i = 0; i < game_allState.Length; i++)
        {
            if (imageName == game_allState[i].ToString())
            {
                state_Game = game_allState[i];
                Switch_Game();
                break;
            }
        }
    }

    void Switch_Main()
    {
        switch (state_Main)
        {
            case MainSceneState.Ssileum:
                //씨름 오브젝트가 표시되어야하고
                GameObject ssileumObject = Instantiate(MSLP.main_Object[0].gameObject);
                ssileumObject.transform.position = new Vector3(0, -1, 1);

                //오디오 클립을 씨름에관한것으로 장전
                audioClip = MSLP.audioList[0];
                StartCoroutine(PlayAudio(audioClip, 1f));

                break;
            case MainSceneState.Daedongyeojido:
                //대동여지도 오브젝트가 나타나야하고
                GameObject daedongyeojido = Instantiate(MSLP.main_Object[1].gameObject);
                daedongyeojido.transform.position = new Vector3(0, 0, 1);

                //오디오클립을 대동여지도에 관한것으로 장전
                audioClip = MSLP.audioList[1];
                StartCoroutine(PlayAudio(audioClip,2f));

                break;
            case MainSceneState.DaboTower:
                //다보탑 스크립트를 AR Session Origin에게 Add Component 해야한다.
                arOrigin = GameObject.FindGameObjectWithTag("Player");
                arOrigin.AddComponent<ARRaycastManager>();
                arOrigin.AddComponent<Dabotop_Appear>();
                //Text debugText = GameObject.Find("Text").GetComponent<Text>();
                //debugText.text = "얄리얄리얄라셩";

                //다보탑 모델을 보여주고
                GameObject daboTower = Instantiate(MSLP.main_Object[2].gameObject);
                daboTower.transform.position = new Vector3(0,-0.7f,1);

                //오디오 클립을 다보탑에 관한것으로 장전
                audioClip = MSLP.audioList[2];
                break;
            case MainSceneState.Main_Over:
                break;
        }
    }

    void Switch_Game()
    {
        switch (state_Game)
        {
            case GameSceneState.Ssileum:
                //틀린그림찾기 게임오브젝트가 나와야한다.
                GameObject ssileum = Instantiate(GSLP.game_Object[0]);
                ssileum.transform.position = new Vector3(0.58f,0,1);
                break;
            case GameSceneState.Daedongyeojido:
                //대동여지도 게임을 하는데 필요한 스크립트를 넣어주자
                arOrigin = GameObject.FindGameObjectWithTag("Player");
                arOrigin.AddComponent<SM_ARManager>();

                //대동여지전도 게임오브젝트가 나와야한다.
                GameObject daedongyeojido = Instantiate(GSLP.game_Object[1]);
                daedongyeojido.transform.position = new Vector3(0,0,5);
                break;
            case GameSceneState.DaboTower:
                //debugText.text = "WoW";
                //다보탑은 스크립트를 켜줘야한다.
                GameObject daboTower = Instantiate(GSLP.game_Object[2]);
                daboTower.transform.position = new Vector3(-6f,-7f,11f);
                break;
            case GameSceneState.Game_Over:
                break;
        }
    }

    public IEnumerator PlayAudio(AudioClip x, float f)
    {
        yield return new WaitForSeconds(f);
        //클립(x)를 넣어서 오디오을 플레이 하자.
        audioSource.clip = x;
        audioSource.Play();
    }
    private void Update()
    {
        //씬에따라 사용할 스테이트를 분류해주는 함수
        Switch_WhatIsThisScene();
    }
}
