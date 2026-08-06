package com.sulake.habbo.toolbar.extensions.purse
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.Motions;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.utils.FriendlyTime;
   
   public class PurseClubArea extends CurrencyIndicatorBase
   {
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private static const ICON_STYLE_CLUB:int = 13;
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const ICON_ANIMATION:Array = ["toolbar_hc_icon_0","toolbar_hc_icon_1","toolbar_hc_icon_2","toolbar_hc_icon_1","toolbar_hc_icon_0"];
      
      private var UnknownVarFromPurseClubArea_Int_1:int = -1;
      
      private var _toolbar:HabboToolbar;
      
      private var _clubMinutes:int;
      
      public function PurseClubArea(param1:HabboToolbar, param2:IWindowController_1)
      {
         super(param1.windowManager,param1.assets);
         _toolbar = param1;
         _window = param2;
         this.bgColorLight = 4286084205;
         this.bgColorDark = 4283781966;
         this.textElementName = "days";
         this.iconAnimationSequence = ICON_ANIMATION;
         this.iconAnimationDelay = 50;
         this.amountZeroText = _toolbar.localization.getLocalization("purse.clubdays.zero.amount.text","Get");
         onClubChanged(new HabboInventoryHabboClubEvent());
      }
      
      override protected function setAmount(param1:int, param2:int = -1) : void
      {
         if(param1 < 1)
         {
            _window.findChildByName("days").visible = false;
            _window.findChildByName("join").visible = true;
            this.textElementName = "join";
            this.setText(this.amountZeroText);
         }
         else
         {
            _window.findChildByName("days").visible = true;
            _window.findChildByName("join").visible = false;
            this.textElementName = "days";
            if(param2 != -1 && param2 < 1440)
            {
               this.setText(FriendlyTime.getShortFriendlyTime(_toolbar.catalog.localization,param2 * 60));
            }
            else
            {
               this.setText(FriendlyTime.getShortFriendlyTime(_toolbar.catalog.localization,param1 * 86400));
            }
         }
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = _window.findChildByName("club_icon") as IIconWindow;
         if(_loc2_)
         {
            _loc2_.style = param1;
            _loc2_.invalidate();
         }
      }
      
      override public function dispose() : void
      {
         _toolbar = null;
         super.dispose();
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent = null) : void
      {
         var _loc3_:IWindowController_1 = null;
         if(!_toolbar.inventory)
         {
            return;
         }
         var _loc4_:int = _toolbar.inventory.clubPeriods * 31 + _toolbar.inventory.clubDays;
         var _loc2_:int = _toolbar.inventory.clubMinutesUntilExpiration;
         if(UnknownVarFromPurseClubArea_Int_1 != -1 && _toolbar.inventory.clubLevel != 0)
         {
            setAmount(_loc4_,_loc2_);
            _loc3_ = _window.findChildByName("hc_join_button") as IWindowController_1;
            if(Motions.getMotionByTarget(_loc3_) == null)
            {
               Motions.runMotion(new DropBounce(_loc3_,900,16));
            }
         }
         UnknownVarFromPurseClubArea_Int_1 = _loc4_;
         _clubMinutes = _loc2_;
         switch(_toolbar.inventory.clubLevel)
         {
            case 0:
               setClubIcon(14);
               setText(this.amountZeroText);
               break;
            case 1:
               setClubIcon(13);
               break;
            case 2:
               setClubIcon(14);
         }
      }
   }
}

