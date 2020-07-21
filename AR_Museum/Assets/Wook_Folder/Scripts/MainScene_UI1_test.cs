using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainScene_UI1 : MonoBehaviour
{
    AudioSource audioSource;
    public float howManny;

    public GameObject PauseButton;
    public GameObject PlayButton;

    // Start is called before the first frame update
    void Start()
    {
        audioSource = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<AudioSource>();
    }

    public void Audio_Forward()
    {
        //버튼을 눌렀을때 현재 재생중인지 물어본다
        //만약 재생중이라면 멈추고
        Audio_Stop();
        if (audioSource.time > audioSource.clip.length)
        {
            audioSource.time = audioSource.clip.length;
            audioSource.Stop();
            audioSource.time = 0;
        }
        //새로운 값을 할당해준다.
        audioSource.time += howManny;
        //재생한다.
        Audio_Play();
    }
    public void Audio_Back()
    {
        Debug.Log("11111111111111111111111111");
        Audio_Stop();
        //만약에 전체 플레이 타임이 요구한 howManny보다 작으면
        //오디오 타임은 0
        if (audioSource.time < howManny)
        {
            audioSource.time = 0;
        }
        else audioSource.time -= howManny;
        Audio_Play();
    }

    public void Audio_Stop()
    {
        //만약 플레이중이라면 멈춰라
        if (audioSource.isPlaying)
        {
            audioSource.Pause();
            gameObject.SetActive(false);
            PlayButton.SetActive(true);
        }
    }

    public void Audio_Play()
    {
        if (audioSource.isPlaying == false)
        {
            audioSource.Play();
            gameObject.SetActive(false);
            PauseButton.SetActive(true);
        }
    }
    
    //씬을 마커카메라로 넘기고싶다.
    public void Go_MarkerCameraScene()
    {
        //그전에 이거 초기화
        if (ObjManager.instance != null)
        {
            ObjManager.instance.imageName = null;
        }
        SceneManager.LoadScene("SM_MarkerCameraScene");
    }

    public void Go_GameScene()
    {
        SceneManager.LoadScene("SM_GameScene");
    }

    public void Go_SelfCameraScene()
    {
        SceneManager.LoadScene("SM_SelfCameraScene");
    }

    public void Taking_Pictures()
    {
        //카메라를 찍고싶어요
    }
}
