package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import flash.geom.Rectangle;
   
   public class AvatarContextInfoButtonView extends ButtonMenuView
   {
      protected var _userId:int;
      
      protected var _userName:String;
      
      protected var _userType:int;
      
      protected var _allowNameChange:Boolean;
      
      protected var _roomIndex:int;
      
      protected var UnknownVarFromAvatarContextInfoButtonView_Boolean_1:Boolean;
      
      public function AvatarContextInfoButtonView(param1:UnknownIHabboUiWidgetContextmenu1)
      {
         super(param1);
      }
      
      public static function setup(param1:AvatarContextInfoButtonView, param2:int, param3:String, param4:int, param5:int, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
         param1._userId = param2;
         param1._userName = param3;
         param1._userType = param5;
         param1._roomIndex = param4;
         param1._allowNameChange = param6;
         param1.UnknownVarFromContextInfoView_Boolean_5 = param7;
         param1.UnknownVarFromAvatarContextInfoButtonView_Boolean_1 = param8;
         setupContext(param1);
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userType() : int
      {
         return _userType;
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get allowNameChange() : Boolean
      {
         return _allowNameChange;
      }
      
      public function get isBlocked() : Boolean
      {
         return isBlocked;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc3_:IWindowModel = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("avatar_info_widget").content as XML;
            _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
            if(!_window)
            {
               return;
            }
         }
         var _loc2_:ITextWindow = _window.findChildByName("name") as ITextWindow;
         if(UnknownVarFromAvatarContextInfoButtonView_Boolean_1)
         {
            _loc2_.italic = true;
            _loc2_.caption = "${infostand.blocked_user}";
         }
         else
         {
            _loc2_.italic = false;
            _window.findChildByName("name").caption = _userName;
         }
         updateRelationshipStatus();
         if(!_allowNameChange)
         {
            _window.findChildByName("change_name_container").visible = false;
            _window.height = 39;
         }
         else
         {
            _loc3_ = _window.findChildByName("change_name_container");
            _loc3_.visible = true;
            _window.height = 39 + _loc3_.height;
            addMouseClickListener(_window.findChildByName("change_name_container"),clickHandler);
         }
         activeView = _window;
      }
      
      override protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -UnknownVarFromContextInfoView_IWindowController_1_2.height;
         if(_userType == 1 || _userType == 3 || _userType == 4)
         {
            _loc2_ += param1.height > 50 ? 25 : 0;
         }
         else
         {
            _loc2_ -= 4;
         }
         return _loc2_;
      }
      
      protected function updateRelationshipStatus() : void
      {
         var _loc1_:IStaticBitmapWrapperWindow = null;
         if(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 && UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.friendList)
         {
            _loc1_ = IStaticBitmapWrapperWindow(_window.findChildByName("relationship_status"));
            _loc1_.assetUri = "relationship_status_" + RelationshipStatusEnum.statusAsString(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.friendList.getRelationshipStatus(userId));
         }
      }
   }
}

