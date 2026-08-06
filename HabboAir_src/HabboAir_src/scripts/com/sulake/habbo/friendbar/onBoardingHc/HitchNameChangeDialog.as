package com.sulake.habbo.friendbar.onBoardingHc
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import onBoardingHcUi.LoaderUI;
   import onBoardingHcUi.NineSplitSprite;
   import onBoardingHcUi.WaitIndicator;
   
   public class HitchNameChangeDialog extends NameChangeDialog
   {
      private var icon_name_ok_png:Class = icon_name_ok_1_png;
      
      private var icon_name_alert_png:Class = icon_name_alert_1_png;
      
      public function HitchNameChangeDialog(param1:IOnBoardingHcFlow, param2:Sprite, param3:int)
      {
         super(param1,param2,param3);
      }
      
      override protected function init() : void
      {
         _style = 2;
         UnknownVarFromNameChangeDialog_Sprite_1 = LoaderUI.createFrame("","",new Rectangle(-_dialogWidth / 2,0,_dialogWidth,1),_style);
         _container.addChild(UnknownVarFromNameChangeDialog_Sprite_1);
         var _loc5_:int = 0;
         var _loc4_:int = 330;
         var _loc1_:int = _dialogWidth - 12;
         var _loc8_:Boolean = false;
         var _loc2_:Sprite = new Sprite();
         UnknownVarFromNameChangeDialog_Bitmap_3 = NineSplitSprite.INPUT_FIELD_HITCH.render(_loc4_,31);
         _loc2_.addChild(UnknownVarFromNameChangeDialog_Bitmap_3);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(_loc2_);
         _loc2_.x = _loc5_;
         var _loc7_:Bitmap = null;
         var _loc3_:TextField = LoaderUI.createTextField(_context.getLocalization("onboarding.characters.tip","TIP: There are tons of Habbos created every day"),18,8309486,false,true,false,false);
         _loc3_.width = _loc4_ - 32;
         var _loc6_:TextField = LoaderUI.createTextField(_context.getLocalization("onboarding.creative.tip","be creative! You can also use these special characters"),18,8309486,false,true,false,false);
         _loc6_.width = _loc4_ - 32;
         UnknownVarFromNameChangeDialog_Sprite_3 = new Sprite();
         var _loc9_:Bitmap = LoaderUI.createBalloon(295,230,45,false,995918,"down");
         _loc9_.y = 90;
         UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc9_);
         UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc3_);
         UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc6_);
         _loc3_.x = 16;
         _loc3_.y = _loc9_.y + (_loc9_.height - (_loc3_.height + _loc6_.height)) / 2;
         _loc3_.width = 250;
         UnknownVarFromNameChangeDialog_Sprite_3.visible = false;
         _loc6_.x = 16;
         _loc6_.y = _loc3_.y + _loc3_.height + 20;
         _loc6_.width = 250;
         if(_loc7_ != null)
         {
            UnknownVarFromNameChangeDialog_Sprite_3.addChild(_loc7_);
            _loc7_.x = 16;
            _loc7_.y = int((UnknownVarFromNameChangeDialog_Sprite_3.height - _loc7_.height) / 2);
         }
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_Sprite_3);
         UnknownVarFromNameChangeDialog_Sprite_3.x = _loc5_;
         _inputDefaultString = _context.getLocalization("name","Enter name here");
         UnknownVarFromNameChangeDialog_TextField_1 = LoaderUI.createTextField(_inputDefaultString,18,6710886,true,false,true,false);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_TextField_1);
         UnknownVarFromNameChangeDialog_TextField_1.x = _loc2_.x + 16;
         UnknownVarFromNameChangeDialog_TextField_1.y = _loc2_.y + int((_loc2_.height - UnknownVarFromNameChangeDialog_TextField_1.height) / 2);
         UnknownVarFromNameChangeDialog_TextField_1.width = _loc2_.width - 30;
         UnknownVarFromNameChangeDialog_TextField_1.addEventListener("click",onInputClicked);
         UnknownVarFromNameChangeDialog_TextField_1.addEventListener("change",onInputChange);
         UnknownVarFromNameChangeDialog_Bitmap_1 = new icon_name_ok_png();
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_Bitmap_1);
         UnknownVarFromNameChangeDialog_Bitmap_1.y = _loc2_.y + int((_loc2_.height - UnknownVarFromNameChangeDialog_Bitmap_1.height) / 2);
         UnknownVarFromNameChangeDialog_Bitmap_1.x = _loc2_.x + _loc2_.width - UnknownVarFromNameChangeDialog_Bitmap_1.width - 7;
         UnknownVarFromNameChangeDialog_Bitmap_2 = new icon_name_alert_png();
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_Bitmap_2);
         UnknownVarFromNameChangeDialog_Bitmap_2.x = UnknownVarFromNameChangeDialog_Bitmap_1.x;
         UnknownVarFromNameChangeDialog_Bitmap_2.y = UnknownVarFromNameChangeDialog_Bitmap_1.y;
         nameIsCorrect = false;
         UnknownVarFromNameChangeDialog_WaitIndicator_1 = new WaitIndicator(_style);
         UnknownVarFromNameChangeDialog_Sprite_1.addChild(UnknownVarFromNameChangeDialog_WaitIndicator_1);
         UnknownVarFromNameChangeDialog_WaitIndicator_1.y = _loc2_.y + int(_loc2_.height / 2) + 2;
         UnknownVarFromNameChangeDialog_WaitIndicator_1.x = _loc2_.x + _loc2_.width - int(UnknownVarFromNameChangeDialog_Bitmap_1.width / 2) - 7;
         UnknownVarFromNameChangeDialog_WaitIndicator_1.visible = false;
         _loc2_.addEventListener("click",onInputBackgroundClicked);
         UnknownVarFromNameChangeDialog_Sprite_1.y = -50;
      }
   }
}

