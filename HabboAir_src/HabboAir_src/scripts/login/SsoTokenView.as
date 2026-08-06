package login
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.Timer;
   import onBoardingHcUi.Button;
   import onBoardingHcUi.ColouredButton;
   import onBoardingHcUi.InputField;
   import onBoardingHcUi.LoaderUI;
   
   public class SsoTokenView extends Sprite
   {
      private var _context:LoginFlow;
      
      private var UnknownVarFromSsoTokenView_TextField_1:TextField;
      
      private var UnknownVarFromSsoTokenView_ColouredButton_1:ColouredButton;
      
      private var UnknownVarFromSsoTokenView_ColouredButton_2:ColouredButton;
      
      private var _loginAreaWidth:int = 640;
      
      private var UnknownVarFromSsoTokenView_InputField_1:InputField;
      
      private var UnknownVarFromSsoTokenView_Boolean_1:Boolean;
      
      public function SsoTokenView(param1:LoginFlow)
      {
         super();
         _context = param1;
         addEventListener("addedToStage",onAddedToStage);
         init();
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromSsoTokenView_InputField_1)
         {
            UnknownVarFromSsoTokenView_InputField_1.removeEventListener("change",onInputChange);
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:Timer = new Timer(20,1);
         _loc2_.addEventListener("timerComplete",onAlignElements);
         _loc2_.start();
         this.UnknownVarFromSsoTokenView_InputField_1.ForcedFocus();
      }
      
      private function onAlignElements(param1:TimerEvent) : void
      {
         LoaderUI.alignAnchors(UnknownVarFromSsoTokenView_InputField_1,0,"r",UnknownVarFromSsoTokenView_ColouredButton_1);
         LoaderUI.alignAnchors(UnknownVarFromSsoTokenView_ColouredButton_1,-20 - UnknownVarFromSsoTokenView_ColouredButton_2.width,"l",UnknownVarFromSsoTokenView_ColouredButton_2);
         Logger.log("(login) Buttons: " + [UnknownVarFromSsoTokenView_ColouredButton_1.x,UnknownVarFromSsoTokenView_ColouredButton_1.y,UnknownVarFromSsoTokenView_ColouredButton_2.x,UnknownVarFromSsoTokenView_ColouredButton_2.y]);
      }
      
      public function init() : void
      {
         if(UnknownVarFromSsoTokenView_Boolean_1)
         {
            return;
         }
         UnknownVarFromSsoTokenView_Boolean_1 = true;
         addTitleField();
         addInputFields();
         addButtons();
      }
      
      private function addTitleField() : void
      {
         if(!UnknownVarFromSsoTokenView_TextField_1)
         {
            UnknownVarFromSsoTokenView_TextField_1 = LoaderUI.createTextField("Habbo AIR Plus",40,16757492,false,true,false,false,"left");
            UnknownVarFromSsoTokenView_TextField_1.x = 0;
            UnknownVarFromSsoTokenView_TextField_1.y = 0;
            UnknownVarFromSsoTokenView_TextField_1.width = 500;
            UnknownVarFromSsoTokenView_TextField_1.multiline = false;
            UnknownVarFromSsoTokenView_TextField_1.thickness = 50;
            addChild(UnknownVarFromSsoTokenView_TextField_1);
         }
      }
      
      private function addInputFields() : void
      {
         UnknownVarFromSsoTokenView_InputField_1 = new InputField(_context,_loginAreaWidth,"${login.login_code.title}","","${login.login_code.login}","",true);
         addChild(UnknownVarFromSsoTokenView_InputField_1);
         UnknownVarFromSsoTokenView_InputField_1.addEventListener("change",onInputChange);
         UnknownVarFromSsoTokenView_InputField_1.addEventListener("keyDown",onInputKeyboardEvent);
         UnknownVarFromSsoTokenView_InputField_1.x = 0;
         UnknownVarFromSsoTokenView_InputField_1.y = 100;
      }
      
      private function onInputKeyboardEvent(param1:KeyboardEvent) : void
      {
         if(param1.charCode == 13)
         {
            if(UnknownVarFromSsoTokenView_ColouredButton_1 && UnknownVarFromSsoTokenView_ColouredButton_1.active)
            {
               onLogin(null);
            }
         }
      }
      
      private function onInputChange(param1:Event) : void
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         if(validateToken(_loc2_))
         {
            _context.updateEnvironment(_loc2_[0],true);
            UnknownVarFromSsoTokenView_ColouredButton_1.active = true;
         }
         else
         {
            UnknownVarFromSsoTokenView_ColouredButton_1.active = false;
         }
      }
      
      public function addButtons() : void
      {
         UnknownVarFromSsoTokenView_ColouredButton_2 = new ColouredButton("red","${generic.cancel}",new Rectangle(0,300,0,40),true,onCancel,14211288);
         addChild(UnknownVarFromSsoTokenView_ColouredButton_2);
         UnknownVarFromSsoTokenView_ColouredButton_1 = new ColouredButton("gfreen","${connection.login.play}",new Rectangle(0,300,0,40),true,onLogin,14211288);
         UnknownVarFromSsoTokenView_ColouredButton_1.active = false;
         addChild(UnknownVarFromSsoTokenView_ColouredButton_1);
      }
      
      private function onLogin(param1:Button) : void
      {
         var _loc2_:Vector.<String> = new Vector.<String>();
         if(validateToken(_loc2_))
         {
            _context.initLoginWithSsoToken(_loc2_[0],_loc2_[1] + "." + _loc2_[2]);
         }
         else
         {
            UnknownVarFromSsoTokenView_ColouredButton_1.active = false;
         }
      }
      
      private function validateToken(param1:Vector.<String>) : Boolean
      {
         var _loc4_:String = UnknownVarFromSsoTokenView_InputField_1.text;
         if(!_loc4_)
         {
            return false;
         }
         if(_loc4_.length == 0)
         {
            return false;
         }
         var _loc3_:Array = _loc4_.split(".");
         if(_loc3_.length < 3 && _loc3_.length < 3)
         {
            return false;
         }
         var _loc2_:String = String(_loc3_[0]).replace("hh","");
         _loc2_ = _loc2_.replace("br","pt");
         _loc2_ = _loc2_.replace("us","en");
         param1.push(_loc2_);
         param1.push(_loc3_[1]);
         param1.push(_loc3_[2]);
         return true;
      }
      
      private function onCancel(param1:Button) : void
      {
         _context.showScreen(1);
      }
      
      public function ready() : void
      {
         if(UnknownVarFromSsoTokenView_ColouredButton_1 != false)
         {
            UnknownVarFromSsoTokenView_ColouredButton_1.active = true;
         }
      }
   }
}

