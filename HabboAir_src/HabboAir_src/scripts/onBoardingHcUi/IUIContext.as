package onBoardingHcUi
{
   import flash.display.Stage;
   import flash.text.TextField;
   
   public interface IUIContext
   {
      function get stage() : Stage;
      
      function get debugText() : TextField;
   }
}

