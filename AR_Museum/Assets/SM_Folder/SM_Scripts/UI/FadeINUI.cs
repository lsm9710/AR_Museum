using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FadeINUI : MonoBehaviour
{
    public Image fadeImage;

    float fades = 1f;
    float currentTime = 0f;

    float delayTime = 3f;

    // Update is called once per frame
    void Update()
    {
        delayTime -= Time.deltaTime;
        if (delayTime >= 0)
        {
            currentTime += Time.deltaTime;
            if (fades >= 0.0f && currentTime >= 0.1f)
            {
                fades -= 0.1f;
                fadeImage.color = new Color(0, 0, 0, fades);
                currentTime = 0f;
            }
            else if (fades >= 2.0f)
            {
                currentTime = 0f;
            }
        }
    }
}
