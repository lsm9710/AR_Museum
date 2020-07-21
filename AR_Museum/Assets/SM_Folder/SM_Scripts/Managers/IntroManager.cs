using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class IntroManager : MonoBehaviour
{
    public Image fadeImage;

    float fades;
    float currentTime = 0f;

    float delayTime = 0f;

    private void Update()
    {
        delayTime += Time.deltaTime;
        if (delayTime >=3)
        {
            currentTime += Time.deltaTime;
            if (fades >= 0.0f && currentTime >= 0.1f)
            {
                fades += 0.1f;
                fadeImage.color = new Color(0, 0, 0, fades);
                currentTime = 0f;
            }
            else if (fades >= 2.0f)
            {
                SceneManager.LoadScene("Rally_MenuScene");
                currentTime = 0f;
            }
        }
    }
}
