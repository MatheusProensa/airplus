package login
{
   import com.sulake.habbo.communication.login.AvatarData;
   import onBoardingHcUi.IUIContext;
   
   public interface ILoginContext extends IUIContext
   {
      function initLogin(param1:String, param2:String) : void;
      
      function initLoginWithSsoToken(param1:String, param2:String) : void;
      
      function loginWithAvatar(param1:AvatarData) : void;
      
      function showScreen(param1:int) : void;
   }
}

