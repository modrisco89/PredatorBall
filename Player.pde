public class Player
{
  private String playerName;//private string playerName
  private int[] scores;//private array of scores
  private int count;//private int of count

  public Player(String playerName, int numberOfGames)
  {
    if (playerName.length() < 3) //check length of string is less than 3
    {
      this.playerName = playerName;
      if (playerName.length()==0) {//check if length is 0, then set to "you" as default
        this.playerName = "YOU";
      }
    } else
    {
      this.playerName = playerName.substring(0, 3);//if greater than length, take only 3 characters
    }
    scores = new int[numberOfGames];//set array length to number of games
    count = 0;//set count to 0
  }
  //public constructor which takes in playername and numberofGames

  //accessors
  public String getPlayerName()
  {
    return playerName;
  }//getter

  public int[] getscores()
  {
    return scores;
  }//getter

  //mutator for player name
  public void setPlayerName(String playerName)
  {
    this.playerName = playerName.substring(0, 3);
  }//setter

  //mutator for high score array
  public void setscores(int[] scores)
  {
    this.scores = scores;
  }//setter

  //method to add a score at the next available location in the scores array   
  public void addScore(int score)
  {
    if (score >= 0) {
      scores[count] = score;
      count++;
    }
  }

  public String toString()
  {
    String str = "Scores for " + playerName + "\n";//set str to player name and new line

    for (int i = 0; i < count; i++) {
      str = str + "     Life " + (i+1) + ": " + scores[i] + "\n";
    }   //increment string by concatenating with the array of scores
    return str;//return str
  }
}
