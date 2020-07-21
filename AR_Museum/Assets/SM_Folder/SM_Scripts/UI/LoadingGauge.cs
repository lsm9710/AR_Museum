using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LoadingGauge : MonoBehaviour
{
    public Image fillImage;
    public FadeINUI fadeUI;
    public GameObject loadingUI;
    float maxGauge = 6f;
    float currentGauge;

    private void FixedUpdate()
    {
        currentGauge += Time.deltaTime;
        fillImage.fillAmount = currentGauge / maxGauge;
        if(currentGauge >= maxGauge)
        {
            fadeUI.enabled = true;
            loadingUI.SetActive(false);
            this.enabled = false;
        }
    }
}
