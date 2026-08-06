package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class Badge
   {
      public static var UnknownVarFromBadge_IWindowController_1_1:IWindowController_1;
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
      
      private var UnknownVarFromBadge_Boolean_1:Boolean = false;
      
      private var _badgeId:String;
      
      private var _isInUse:Boolean;
      
      private var _isSelected:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromBadge_IWindowModel_1:IWindowModel;
      
      private var _isUnseen:Boolean;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var UnknownVarFromBadge_BadgesModel_1:BadgesModel;
      
      private var _ownerCount:int;
      
      private var _badgeRarityId:int;
      
      public function Badge(param1:BadgesModel, param2:String, param3:String, param4:String, param5:Boolean, param6:int, param7:int)
      {
         super();
         UnknownVarFromBadge_BadgesModel_1 = param1;
         _badgeId = param2;
         _name = param3;
         _desc = param4;
         _isUnseen = param5;
         _ownerCount = param6;
         _badgeRarityId = param7;
         this.isSelected = false;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get badgeName() : String
      {
         return _name;
      }
      
      public function get badgeDescription() : String
      {
         return _desc;
      }
      
      public function get ownerCount() : int
      {
         return _ownerCount;
      }
      
      public function get badgeRarityId() : int
      {
         return _badgeRarityId;
      }
      
      public function get isInUse() : Boolean
      {
         return _isInUse;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function get window() : IWindowController_1
      {
         if(!UnknownVarFromBadge_Boolean_1)
         {
            initWindow();
         }
         return _window;
      }
      
      private function initWindow() : void
      {
         _window = UnknownVarFromBadge_IWindowController_1_1.clone() as IWindowController_1;
         IBadgeImageWidget(IWidgetWindowController(_window.findChildByName("badge")).widget).badgeId = badgeId;
         _window.findChildByName("badge").visible = true;
         UnknownVarFromBadge_IWindowModel_1 = _window.findChildByTag("BG_COLOR");
         UnknownVarFromBadge_Boolean_1 = true;
         _window.procedure = itemEventProc;
      }
      
      private function itemEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            UnknownVarFromBadge_BadgesModel_1.setBadgeSelected(this.badgeId);
         }
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         _isInUse = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(UnknownVarFromBadge_IWindowModel_1 == null || _window == null)
         {
            return;
         }
         UnknownVarFromBadge_IWindowModel_1.color = _isUnseen ? 10275685 : 13421772;
         _window.findChildByName("outline").visible = param1;
      }
      
      public function set isUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            this.isSelected = _isSelected;
         }
      }
      
      public function updateMetadata(param1:int, param2:int) : void
      {
         _ownerCount = param1;
         _badgeRarityId = param2;
      }
   }
}

