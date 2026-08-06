package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.IHallOfFameEntryData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class UserListWidget implements ILandingViewWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var _popup:IWindowController_1;
      
      private var UnknownVarFromUserListWidget_Int_1:int = 150;
      
      private var UnknownVarFromUserListWidget_Array_1:Array = [0,10,5,0,5,10,0,10,5,10];
      
      private var UnknownVarFromUserListWidget_Array_2:Array = [];
      
      private var UnknownVarFromUserListWidget_Array_3:Array = [2,4,2,2,4,2,2,2,4,2];
      
      public function UserListWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         if(_popup != null)
         {
            _popup.dispose();
            _popup = null;
         }
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("user_list"));
         registerMessageListeners();
      }
      
      public function refresh() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function refreshContent() : void
      {
         if(users == null)
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         refreshList();
         backToDefaultPopup();
      }
      
      private function refreshList() : void
      {
         var _loc5_:int = 0;
         var _loc6_:IWindowController_1 = null;
         var _loc1_:IHallOfFameEntryData = null;
         var _loc3_:IWidgetWindowController = null;
         var _loc4_:IAvatarImageWidget = null;
         var _loc2_:int = UnknownVarFromUserListWidget_Int_1;
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc6_ = getAvatarContainer(_loc5_);
            if(_loc6_ == null)
            {
               _loc6_ = createAvatarContainer(_loc5_);
               _container.addChild(_loc6_);
               _loc6_.x = _loc2_;
               _loc2_ += _loc6_.width;
            }
            _loc1_ = users[_loc5_];
            _loc6_.visible = _loc1_ != null;
            if(_loc1_)
            {
               _loc3_ = IWidgetWindowController(_loc6_.findChildByName("avatar_image_widget"));
               _loc4_ = IAvatarImageWidget(_loc3_.widget);
               _loc4_.figure = _loc1_.figure;
            }
            _loc5_++;
         }
      }
      
      private function getAvatarContainer(param1:int) : IWindowController_1
      {
         return IWindowController_1(_container.getChildByID(param1));
      }
      
      private function createAvatarContainer(param1:int) : IWindowController_1
      {
         var _loc3_:IWindowController_1 = IWindowController_1(_landingView.getXmlWindow("user_entry"));
         setupVariation(_loc3_,param1);
         _loc3_.procedure = onEntry;
         _loc3_.id = param1;
         if(UnknownVarFromUserListWidget_Array_2.length > param1)
         {
            _loc3_.width = UnknownVarFromUserListWidget_Array_2[param1];
         }
         var _loc2_:IWindowModel = _loc3_.findChildByName("extra_link_region");
         _loc2_.visible = hasExtraLink();
         _loc2_.procedure = onExtraLink;
         _loc2_.id = param1;
         return _loc3_;
      }
      
      private function setupVariation(param1:IWindowController_1, param2:int) : void
      {
         var _loc3_:IWidgetWindowController = IWidgetWindowController(param1.findChildByName("avatar_image_widget"));
         var _loc4_:IAvatarImageWidget = IAvatarImageWidget(_loc3_.widget);
         param1.y += UnknownVarFromUserListWidget_Array_1[param2] + 70;
         if(UnknownVarFromUserListWidget_Array_1[param2] < 0)
         {
            param1.height += -UnknownVarFromUserListWidget_Array_1[param2];
         }
         _loc4_.direction = UnknownVarFromUserListWidget_Array_3[param2];
         param1.findChildByName("extra_link_region").y = param1.findChildByName("extra_link_region").y - UnknownVarFromUserListWidget_Array_1[param2];
      }
      
      private function getEntry(param1:IWindowModel) : IHallOfFameEntryData
      {
         var _loc2_:int = param1.id;
         return users[_loc2_];
      }
      
      private function onEntry(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IHallOfFameEntryData = getEntry(param2);
         if(_loc3_ == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new GetExtendedProfileMessageComposer(_loc3_.userId));
         }
         else if(param1.type == "WME_OVER")
         {
            showPopup(_loc3_,param2);
         }
         else if(param1.type == "WME_OUT")
         {
            backToDefaultPopup();
         }
      }
      
      private function onExtraLink(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IHallOfFameEntryData = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = getEntry(param2);
            if(_loc3_ == null)
            {
               return;
            }
            extraLinkClicked(_loc3_);
         }
         else
         {
            onEntry(param1,param2.parent);
         }
      }
      
      private function showPopup(param1:IHallOfFameEntryData, param2:IWindowModel) : void
      {
         if(_popup == null)
         {
            _popup = IWindowController_1(_landingView.getXmlWindow(getPopupXml()));
            _container.addChild(_popup);
         }
         refreshPopup(param1,_popup);
         _popup.y = Math.max(0,79 - _popup.height);
         _popup.x = param2.x + (param2.width - _popup.width) / 2;
         _popup.visible = true;
      }
      
      private function backToDefaultPopup() : void
      {
         if(users.length > 0)
         {
            showPopup(users[0],_container.getChildByID(0));
         }
         else if(_popup != null)
         {
            _popup.visible = false;
         }
      }
      
      protected function get landingView() : HabboLandingView
      {
         return _landingView;
      }
      
      protected function getText(param1:String) : String
      {
         return "${" + param1 + "}";
      }
      
      protected function registerMessageListeners() : void
      {
      }
      
      protected function get users() : Array
      {
         return null;
      }
      
      protected function refreshPopup(param1:IHallOfFameEntryData, param2:IWindowController_1) : void
      {
      }
      
      protected function getPopupXml() : String
      {
         return null;
      }
      
      protected function hasExtraLink() : Boolean
      {
         return false;
      }
      
      protected function extraLinkClicked(param1:IHallOfFameEntryData) : void
      {
      }
      
      protected function set avatarOffsetsY(param1:Array) : void
      {
         UnknownVarFromUserListWidget_Array_1 = param1;
      }
      
      protected function set avatarContainerWidths(param1:Array) : void
      {
         UnknownVarFromUserListWidget_Array_2 = param1;
      }
      
      public function set startOffset(param1:int) : void
      {
         UnknownVarFromUserListWidget_Int_1 = param1;
      }
   }
}

