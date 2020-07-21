using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//탭을 하면 점차 다보탑이 보이도록 한다
public class WK_GameTapping : MonoBehaviour
{
    MeshRenderer mr;
    int count = 0;
    float moffsetValue = 3.1f;
    void Start()
    {
         mr = GameObject.Find("Circle002").GetComponent<MeshRenderer>();
        moffsetValue = 3.1f;
        mr.sharedMaterial.SetFloat("_MaskOffset", moffsetValue);
       
    }
    void Update()
    {
        //탭을 하면 숫자를 업카운트 한다
       if( Input.GetMouseButtonDown(0))
        {
            count += 1;
            //material의 MaskOffset값 가져오기
            StartCoroutine(MaskOffsetEffect());
        }
    }

    IEnumerator MaskOffsetEffect()
    {

        while (true) {
            mr.sharedMaterial.SetFloat("_MaskOffset", moffsetValue);
            moffsetValue -= 0.1f;

            if (moffsetValue <= -1)
            {
                moffsetValue = 3.1f;
                mr.sharedMaterial.SetFloat("_MaskOffset", moffsetValue);
                yield break;
            }
            else
            {
                yield return new WaitForSeconds(0.05f);
            }
        }
    }
}
