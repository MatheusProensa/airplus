package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.avatar.UnknownIHabboAvatar3;
   import com.sulake.habbo.inventory.IInventoryMainView;
   import com.sulake.habbo.inventory.IThumbListDrawableItem;
   import com.sulake.habbo.ui.widget.memenu.UnknownIHabboUiWidgetMemenu1;
   import flash.display.BitmapData;
   
   public class Effect implements UnknownIHabboUiWidgetMemenu1, IThumbListDrawableItem, UnknownIHabboAvatar3, IInventoryMainView
   {
      private var _type:int;
      
      private var _subType:int;
      
      private var _duration:int;
      
      private var _amountInInventory:int = 1;
      
      private var UnknownVarFromEffect_Int_1:int;
      
      private var _isPermanent:Boolean = false;
      
      private var _isActive:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      private var _isInUse:Boolean = false;
      
      private var _icon:BitmapData;
      
      private var UnknownVarFromEffect_Date_1:Date;
      
      public function Effect()
      {
         super();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get amountInInventory() : int
      {
         return _amountInInventory;
      }
      
      public function get isPermanent() : Boolean
      {
         return _isPermanent;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get isInUse() : Boolean
      {
         return _isInUse;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get icon() : BitmapData
      {
         return _icon;
      }
      
      public function get iconImage() : BitmapData
      {
         return _icon;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         if(_isActive)
         {
            _loc1_ = UnknownVarFromEffect_Int_1 - (new Date().valueOf() - UnknownVarFromEffect_Date_1.valueOf()) / 1000;
            _loc1_ = Math.floor(_loc1_);
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return UnknownVarFromEffect_Int_1;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function set subType(param1:int) : void
      {
         _subType = param1;
      }
      
      public function set duration(param1:int) : void
      {
         _duration = param1;
      }
      
      public function set secondsLeft(param1:int) : void
      {
         UnknownVarFromEffect_Int_1 = param1;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         _isPermanent = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         _isInUse = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         _icon = param1;
      }
      
      public function set amountInInventory(param1:int) : void
      {
         _amountInInventory = param1;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 && !_isActive)
         {
            UnknownVarFromEffect_Date_1 = new Date();
         }
         _isActive = param1;
      }
      
      public function setOneEffectExpired() : void
      {
         _amountInInventory--;
         if(_amountInInventory < 0)
         {
            _amountInInventory = 0;
         }
         UnknownVarFromEffect_Int_1 = _duration;
         _isActive = false;
         _isInUse = false;
      }
   }
}

