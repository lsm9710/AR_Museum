using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//탑이 가상공간에 등장했다면 오디오모드 돌입
//오디오버튼을 클릭하면 다보탑설명 애니메이션이 오디오에 맞춰서 실행이 된다.
// -오디오 실행중 앞으로 뒤로 가기 모드 가능(3초 씩)
public class Dabotop_Discrips : MonoBehaviour
{
    //오디오 모드인지?
    bool audioMode = false;

    //가상공간에 다보탑 나타나게 하는 스크립
    Dabotop_Appear daboAppear;

    //다보탑 설명 애니메이션
    Animator discriptAnim;

    private void Start()
    {
        daboAppear = GetComponent<Dabotop_Appear>();
        discriptAnim = GetComponent<Animator>();
    }

    void Update()
    {
        //** 임시: 오디오버튼을 클릭(1번 버튼)하면 다보탑설명 애니메이션이 오디오에 맞춰서 실행이 된다.
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            PlayDiscription();
        }
    }

    private void PlayDiscription()
    {
        //오디오모드로 진입했을 때 오디오설명 애니메이션 플레이.
        if (AudioMode()) discriptAnim.Play("MapBoard_Anim");
        else return;
    }

    public bool AudioMode()
    {
        //탑이 가상공간에 등장했다면 오디오모드 돌입 --> 다보탑마커가 사라졌다는 것으로 가상공간에 등장했다고 판단.
        if (daboAppear.daboMark == false) return audioMode = true;

        else return audioMode = false;

    }
}
