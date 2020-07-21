using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//일정크기로 확대되면 천천히 회전 한다
public class WK_RotateOBJ : MonoBehaviour
{
    //회전되는 물체
    //GameObject Dabotop;

    //회전 속도
    public float rotAngle= 0.2f;

    //회전할 시기 판단하는 확대된 치수
    public float scalX = 0.3f;
        
    private void Start()
    {
        //회전물체 찾아오기
       // Dabotop = GameObject.Find("DaboTop_Mini_Discripts(Clone)/DaboTop/Daebotop");
        
    }

    // 회전체가 스케일 확대가 된 이후 회전을 하자
    private void Update()
    {
       // Vector3 daboScal = Dabotop.transform.localScale;
        Vector3 daboScal = transform.localScale;



        //탑의 스케일일 일정한 수치가 되면 회전하자.
        if (daboScal.x >= scalX) RotateDaboTop(rotAngle);
       
        else return;
    }

    //다보탑 회전 시키기
    void RotateDaboTop(float rotAngle)
    {
       // Dabotop.transform.Rotate( new Vector3(0,1,0), rotAngle);
        transform.Rotate( new Vector3(0,0,1), rotAngle);

    }
}
