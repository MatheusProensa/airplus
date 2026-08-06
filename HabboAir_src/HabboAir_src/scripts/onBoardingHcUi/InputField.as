package onBoardingHcUi
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class InputField extends Sprite
   {
      private var _style:int = 2;
      
      private var _disposed:Boolean;
      
      private var _context:IUIContext;
      
      private var _frame:Sprite;
      
      private var _promptField:TextField;
      
      private var _field:TextField;
      
      private var _submitButton:Button;
      
      private var _skipButton:Button;
      
      private var _background:Bitmap;
      
      private var _inputClickedAlready:Boolean;
      
      private var _inputDefaultString:String;
      
      private var _dialogWidth:int;
      
      private var _isPassword:Boolean;
      
      private var _caption:String;
      
      private var _subCaption:String;
      
      private var _maxWidth:Number;
      
      private var _prompt:String;
      
      public function InputField(param1:IUIContext, param2:int, param3:String, param4:String, param5:String, param6:String, param7:Boolean = false)
      {
         super();
         _context = param1;
         _dialogWidth = param2;
         _prompt = param3;
         _inputDefaultString = param4 == null ? "" : param4;
         _caption = param5;
         _subCaption = param6;
         _isPassword = param7;
         init();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_frame)
         {
            removeChild(_frame);
         }
         _field = null;
         _promptField = null;
         _submitButton = null;
         _skipButton = null;
         _background = null;
         _frame = null;
         _context = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function init() : void
      {
         _frame = LoaderUI.createFrame(_caption,_subCaption,new Rectangle(0,0,_dialogWidth,1),_style);
         addChild(_frame);
         var _loc2_:int = 0;
         var _loc1_:Sprite = new Sprite();
         _background = NineSplitSprite.INPUT_FIELD_HITCH.render(_dialogWidth,31);
         _loc1_.addChild(_background);
         _frame.addChild(_loc1_);
         _loc1_.x = _loc2_;
         _maxWidth = _loc1_.width - 30;
         _promptField = LoaderUI.createTextField(_prompt,18,6710886,true,false,false,false);
         _promptField.alpha = 0.8;
         _promptField.x = _loc1_.x + 16;
         _promptField.y = _loc1_.y + int((_loc1_.height - _promptField.height) / 2);
         _promptField.width = _maxWidth;
         _promptField.visible = _inputDefaultString == null || _inputDefaultString.length == 0;
         _frame.addChild(_promptField);
         _field = LoaderUI.createTextField(_inputDefaultString,18,6710886,true,false,true,false);
         _field.displayAsPassword = _isPassword;
         _frame.addChild(_field);
         _field.x = _loc1_.x + 16;
         _field.y = _loc1_.y + int((_loc1_.height - _field.height) / 2);
         _field.width = _maxWidth;
         _field.addEventListener("click",onInputClicked);
         _field.addEventListener("change",onInputChange);
         if(!_inputDefaultString || _inputDefaultString.length == 0)
         {
            _field.autoSize = "none";
            _field.width = _maxWidth;
         }
         _loc1_.addEventListener("click",onInputBackgroundClicked);
         var _loc3_:int = -50;
         _frame.y = -(int(_loc3_ / 2));
      }
      
      private function onInputChange(param1:Event) : void
      {
         _promptField.visible = _field.text.length == 0;
         if(_field.width > _maxWidth)
         {
            _field.autoSize = "none";
            _field.width = _maxWidth;
         }
         if(param1 != null)
         {
            dispatchEvent(param1.clone());
         }
      }
      
      private function onInputBackgroundClicked(param1:MouseEvent) : void
      {
         _context.stage.focus = _field;
         onInputClicked(null);
      }
      
      private function onInputClicked(param1:Event) : void
      {
         if(_inputClickedAlready)
         {
            return;
         }
         _promptField.visible = false;
         _inputClickedAlready = true;
         _field.textColor = _style == 2 ? 6710886 : 0;
         _field.removeEventListener("click",onInputClicked);
         onInputChange(null);
      }
      
      public function get text() : String
      {
         return _field.text;
      }
      
      public function ForcedFocus() : void
      {
         this.onInputBackgroundClicked(null);
      }
   }
}

