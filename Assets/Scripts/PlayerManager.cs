using UnityEngine;
//using HoloToolkit.Unity.SpatialMapping;

public class PlayerManager : MonoBehaviour
{
  
    public GameObject[] playerArray = new GameObject[6];
    public GameObject KinectController;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.B)) nextPlayer();

        if (KinectController.GetComponent<KinectManager>().calibrationText.text == "WAITING FOR USERS") nextPlayer();
        
    }

    public void nextPlayer()
    {
        for (int i = 0; i < playerArray.Length; i++)
        {
            //   if (activateNext > playerArray.Length - 1) activateNext = 0;
            
                playerArray[i].GetComponent<AvatarController>().playerIndex += 1;
                playerArray[i].GetComponent<AvatarScaler>().playerIndex += 1;

            if (playerArray[i].GetComponent<AvatarController>().playerIndex > playerArray.Length -1)
            {
                playerArray[i].GetComponent<AvatarController>().playerIndex = 0;
                playerArray[i].GetComponent<AvatarScaler>().playerIndex = 0;

            }
        }
    }
}



 
