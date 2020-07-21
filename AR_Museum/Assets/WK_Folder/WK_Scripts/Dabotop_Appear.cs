using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using System;
//목표:카메라가 보는 위치에 마커를 위치 시킨다
//마우스 클릭하면 마커 위치에 오브젝트가 나타난다
//한번 오브젝트가 나타나면 화면 터치가 되어도 다시 나타나지 않게 한다

public class Dabotop_Appear : MonoBehaviour
{
  
    //다보탑 메인 설명 프리펩
    GameObject daboMain;

    //다보탑 마커
    public GameObject daboMark;

    //임시 바닥
    public GameObject ground;

    //마커 프리팹
    GameObject mainObj;

    //애니메이션 하는 오브젝트
    GameObject Mini_Discripts;

    //ar용 레이케스트메니져
    ARRaycastManager arRaycateMgr;

    //클릭했을 때 나타날 위치
    Vector3 pos;

    //플레이중인지?
    bool isPlaying = false;

    ObjManager objM;

    //씬이 활성화 될때(스크립트가 활성화될때) 다보탑 팩토리를 리소스 폴더에서 불러와 넣는다.
    //사용자가 입력했을 때 WK_Mainobject를 디스트로이 한다.

    private void Start()
    {
        objM = ObjManager.instance;

#if UNITY_EDITOR
        daboMark = GameObject.Find("Marker_Dabo");
        mainObj = GameObject.FindGameObjectWithTag("mainDaboObj");
#else
        mainObj = GameObject.Find("WK_MainObject");
        //Mini_Discripts = Resources.Load <GameObject>("DaboTop_Mini_Discripts");
        daboMark = GameObject.Find("Marker_Dabo");
        
        arRaycateMgr = GetComponent<ARRaycastManager>();
#endif
    }

    void Update()
    {
        //카메라가 보는 중앙에 마커를 나타 나게 한다

        Ray ray = new Ray(Camera.main.transform.position, Camera.main.transform.forward);

#if UNITY_EDITOR
        RaycastHit hit;
        if (isPlaying == false)
        {
            if (Physics.Raycast(ray, out hit))
            {
                pos = hit.point;

                daboMark.transform.position = pos;
                if (Input.GetMouseButtonDown(0))
                {
                    GameObject animObj = Instantiate(Resources.Load<GameObject>("DaboTop_Mini_Discripts"));
                    animObj.transform.position = daboMark.transform.position;
                    daboMark.SetActive(false);
                    ground.SetActive(false);
                    //daboMain.SetActive(true);
                    //daboMain.transform.position = pos;
                    //사운드메니저로부터 오디오 클립을 가져온다
                    objM.StartCoroutine(objM.PlayAudio(objM.audioClip, 0f));
                    isPlaying = true;
                    if (mainObj != null)
                    {
                        Destroy(mainObj.gameObject);
                    }
                }

            }
        }
#else
        // 설명이 플레이 되고 있지 않을 경우만 실행.(중복 실행 방지)
            if (isPlaying == false)
            {
                List<ARRaycastHit> hits = new List<ARRaycastHit>();
                if (arRaycateMgr.Raycast(ray, hits))
                {
                    pos = hits[0].pose.position;
                     daboMark.transform.position = pos;
                    if (Input.GetMouseButtonDown(0))
                    {
                        GameObject animObj = Instantiate(Resources.Load<GameObject>("DaboTop_Mini_Discripts"));
                        animObj.transform.position = daboMark.transform.position;
                        daboMark.SetActive(false);
                        objM.StartCoroutine(objM.PlayAudio(objM.audioClip, 0f));
                        isPlaying = true;
                        if (mainObj != null)
                        {
                           Destroy(mainObj.gameObject);
                        }
                    }
                }
            }
#endif
    }
}
