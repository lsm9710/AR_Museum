using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tutorial_FinalButton : MonoBehaviour
{
    GameObject page;

    private void Start()
    {
        page = gameObject.transform.parent.gameObject;
    }

    public void ONClicked()
    {
        iTween.MoveBy(page, iTween.Hash("x", -1080, "easeType", iTween.EaseType.easeInBack));
        APPTutorial.instance.AccumulatePoint= APPTutorial.instance.AccumulatePoint+1;
    }
}
