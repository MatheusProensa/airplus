package login
{
   import com.sulake.habbo.utils.CommunicationUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.InputField;
   import onBoardingHcUi.LoaderUI;
   
   public class LoginView extends Sprite
   {
      private var _context:ILoginContext;
      
      private var UnknownVarFromLoginView_TextField_1:TextField;
      
      private var UnknownVarFromLoginView_ColouredButton_1:ColouredButton;
      
      private var UnknownVarFromLoginView_ColouredButton_2:ColouredButton;
      
      private var UnknownVarFromLoginView_InputField_1:InputField;
      
      private var _loginAreaWidth:int = 640;
      
      private var UnknownVarFromLoginView_InputField_2:InputField;
      
      private var UnknownVarFromLoginView_Boolean_1:Boolean;
      
      public function LoginView(param1:ILoginContext)
      {
         super();
         _context = param1;
         addEventListener("addedToStage",onAddedToStage);
         init();
      }
      
      public function dispose() : void
      {
         UnknownVarFromLoginView_ColouredButton_1.dispose();
         UnknownVarFromLoginView_ColouredButton_2.dispose();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Timer = new Timer(20,1);
         _loc2_.addEventListener("timerComplete",onAlignElements);
         _loc2_.start();
      }
      
      private function onAlignElements(param1:TimerEvent) : void
      {
         LoaderUI.lineUpVertically(UnknownVarFromLoginView_InputField_1,-20,UnknownVarFromLoginView_InputField_2);
         LoaderUI.alignAnchors(UnknownVarFromLoginView_InputField_1,0,"l",UnknownVarFromLoginView_InputField_2);
         LoaderUI.alignAnchors(UnknownVarFromLoginView_InputField_1,0,"r",UnknownVarFromLoginView_ColouredButton_1);
         LoaderUI.lineUpHorizontallyRevers(UnknownVarFromLoginView_ColouredButton_1,20,UnknownVarFromLoginView_ColouredButton_2);
         Logger.log("(login) Buttons: " + [UnknownVarFromLoginView_ColouredButton_1.x,UnknownVarFromLoginView_ColouredButton_1.y,UnknownVarFromLoginView_ColouredButton_2.x,UnknownVarFromLoginView_ColouredButton_2.y]);
      }
      
      public function init() : void
      {
         if(UnknownVarFromLoginView_Boolean_1)
         {
            return;
         }
         UnknownVarFromLoginView_Boolean_1 = true;
         addTitleField();
         addInputFields();
         addButtons();
      }
      
      private function addTitleField() : void
      {
         if(!UnknownVarFromLoginView_TextField_1)
         {
            UnknownVarFromLoginView_TextField_1 = LoaderUI.createTextField("${connection.login.title}",40,16777215,false,true,false,false,"left");
            UnknownVarFromLoginView_TextField_1.x = 0;
            UnknownVarFromLoginView_TextField_1.y = 0;
            UnknownVarFromLoginView_TextField_1.width = 500;
            UnknownVarFromLoginView_TextField_1.multiline = false;
            UnknownVarFromLoginView_TextField_1.thickness = 50;
            addChild(UnknownVarFromLoginView_TextField_1);
         }
      }
      
      private function addInputFields() : void
      {
         UnknownVarFromLoginView_InputField_1 = new InputField(_context,_loginAreaWidth,"${connection.login.email}",CommunicationUtils.readSOLString("login"),"${connection.login.missing_credentials}","");
         addChild(UnknownVarFromLoginView_InputField_1);
         UnknownVarFromLoginView_InputField_1.x = 0;
         UnknownVarFromLoginView_InputField_1.y = 100;
         UnknownVarFromLoginView_InputField_2 = new InputField(_context,_loginAreaWidth,"${connection.login.password}",CommunicationUtils.restorePassword(),"","",true);
         addChild(UnknownVarFromLoginView_InputField_2);
      }
      
      public function addButtons() : void
      {
         UnknownVarFromLoginView_ColouredButton_2 = new ColouredButton("red","${generic.cancel}",new Rectangle(0,300,0,40),true,onCancel,14211288);
         addChild(UnknownVarFromLoginView_ColouredButton_2);
         UnknownVarFromLoginView_ColouredButton_1 = new ColouredButton("gfreen","${connection.login.play}",new Rectangle(0,300,0,40),true,saveOutfit,14211288);
         UnknownVarFromLoginView_ColouredButton_1.active = false;
         addChild(UnknownVarFromLoginView_ColouredButton_1);
      }
      
      private function saveOutfit(param1:Button) : void
      {
         _context.initLogin(UnknownVarFromLoginView_InputField_1.text,UnknownVarFromLoginView_InputField_2.text);
      }
      
      private function onCancel(param1:Button) : void
      {
         _context.showScreen(1);
      }
      
      public function ready() : void
      {
         if(UnknownVarFromLoginView_ColouredButton_1 != false)
         {
            UnknownVarFromLoginView_ColouredButton_1.active = true;
         }
      }
   }
}

