using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SM_Game_Timer : MonoBehaviour
{
    GameObject my_camera;

    //=============================

    public float maximumTime = 60f;
    public Image fillImege;
    float currentTime;

    bool gameOver;

    //============================

    public GameObject gameOverCanvas;

    private void Start()
    {
        my_camera = GameObject.FindGameObjectWithTag("MainCamera");
        fillImege.fillAmount = 0f;
    }
    private void Update()
    {
        AlwaysPointTheCamera();

        currentTime += Time.deltaTime;
        fillImege.fillAmount = currentTime / maximumTime;
        //만약 시간이 다 되버리면
        if (currentTime >= 60f && !gameOver)
        {
            gameOver = true;
            StartCoroutine(GameOver());
        }
    }

    IEnumerator GameOver()
    {
        yield return new WaitForSeconds(1f);
        //게임오버 UI를 표시하고싶다.
        gameOverCanvas.SetActive(true);
    }

    void AlwaysPointTheCamera()
    {
        if (my_camera != null)
        {
            transform.LookAt(transform.position + my_camera.transform.rotation * Vector3.back,
            my_camera.transform.rotation * Vector3.up);
        }
    }
}
