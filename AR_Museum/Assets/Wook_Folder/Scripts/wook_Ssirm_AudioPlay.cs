using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wook_Ssirm_AudioPlay : MonoBehaviour
{

    public GameObject[] showObj;
    public GameObject syl;

    public float speed = 17.0f;

    float currentTime=0;

    bool start;
    bool zero;
    bool one;

    bool audio;


    // Start is called before the first frame update
    void Start()
    {
        start = true;
    }

    private void sylshow()
    {
        float rotSpeed = speed * Time.deltaTime;
        syl.transform.Rotate(Vector3.up * rotSpeed);
        //print("done");
        //throw new NotImplementedException();
    }

    // Update is called once per frame
    void Update()
    {
        currentTime += Time.deltaTime;
        
        if(start)
        {
            sylshow();
        }

        // t++

        if(currentTime>10f)
        {
            start = false;

            syl.SetActive(false);

            showObj[0].SetActive(true);

        }
        if(currentTime>15f)
        {
            showObj[1].SetActive(true);
        }
        if(currentTime>21f)
        {
            showObj[2].SetActive(true);
        }
        if (currentTime > 28f)
        {
            showObj[3].SetActive(true);
        }

        //// 유니티 테스트 
        //if (Input.GetMouseButtonDown(0))
        //{
        //    showObj[0].SetActive(true);
        //    //if(audio)
        //    //{
        //    //    audio = false;
        //    //    AudioPlay();
        //    //}

        //    if (zero)
        //    {
        //        showObj[1].SetActive(true);
        //    }
        //    zero = true;

        //    if (showObj[2].activeSelf)
        //    {                
        //        showObj[3].SetActive(true);
        //    }

        //    if (one)
        //    {
        //        showObj[2].SetActive(true);
        //    }

        //    if (showObj[1].activeSelf)
        //    {
        //        one = true;
        //    }

        //}

    }
}
