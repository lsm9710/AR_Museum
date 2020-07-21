using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WorkPositon_Manager : MonoBehaviour
{
    public static WorkPositon_Manager WP;

    public List<GameObject> workPosition;
    public List<GameObject> quarryPosition;
    private void Awake()
    {
        if (WP == null)
        {
            WP = this;
        }
    }

    private void Start()
    {
        Dabo();
        Stone();
    }

    void Dabo()
    {
        //WorkPosition 태그인 오브젝트를 모조리 찾아서 리스트에 넣고 싶다.
        GameObject[] goArray = GameObject.FindGameObjectsWithTag("WorkPosition");

        for (int i = 0; i < goArray.Length; i++)
        {
            workPosition.Add(goArray[i]);
        }
    }

    void Stone()
    {
        GameObject[] goArray = GameObject.FindGameObjectsWithTag("QuarryingPosition");

        for (int i = 0; i < goArray.Length; i++)
        {
            quarryPosition.Add(goArray[i]);
        }
    }
}
