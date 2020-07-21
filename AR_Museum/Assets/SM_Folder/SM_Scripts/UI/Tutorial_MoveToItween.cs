using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tutorial_MoveToItween : MonoBehaviour
{
    GameObject page;

    private void Start()
    {
        page = gameObject.transform.parent.gameObject;
    }
    public void ONClicked()
    {
        Debug.Log("1111111111111111");
        iTween.MoveBy(page, iTween.Hash("x", -1080, "easeType", iTween.EaseType.easeInBack));
    }
}
