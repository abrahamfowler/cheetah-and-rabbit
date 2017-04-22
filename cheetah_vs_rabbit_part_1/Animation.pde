/**
Animations are Designs that can expire
**/
public interface Animation extends Design {
  
  /**
  Tell if the animation has expired and should be deleted
  **/
  public boolean hasExpired();
}
