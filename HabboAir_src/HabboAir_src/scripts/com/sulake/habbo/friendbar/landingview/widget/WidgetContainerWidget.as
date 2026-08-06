package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetCurrentTimingCodeMessageComposer;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.UnknownIHabboFriendbarLandingviewInterfaces2;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.LandingViewWidgetType;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainer;
   import flash.utils.Dictionary;
   
   public class WidgetContainerWidget implements ILandingViewWidget, ISlotAwareWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromWidgetContainerWidget_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromWidgetContainerWidget_CommonWidgetSettings_1:CommonWidgetSettings;
      
      private var UnknownVarFromWidgetContainerWidget_Int_1:int;
      
      private var _schedulingStr:String;
      
      private var UnknownVarFromWidgetContainerWidget_WidgetContainer_1:WidgetContainer;
      
      public function WidgetContainerWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public static function hideChildren(param1:IWindowController_1) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public function set slot(param1:int) : void
      {
         UnknownVarFromWidgetContainerWidget_Int_1 = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("widget_container_widget"));
         UnknownVarFromWidgetContainerWidget_CommonWidgetSettings_1 = new CommonWidgetSettings(_landingView);
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
         _schedulingStr = _landingView.getProperty("landing.view.dynamic.slot." + UnknownVarFromWidgetContainerWidget_Int_1 + ".conf");
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetCurrentTimingCodeMessageComposer(_schedulingStr));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         hideChildren(_container);
         if(UnknownVarFromWidgetContainerWidget_WidgetContainer_1 != null)
         {
            UnknownVarFromWidgetContainerWidget_WidgetContainer_1.refresh(_container);
            UnknownVarFromWidgetContainerWidget_WidgetContainer_1.container.visible = true;
            _container.height = UnknownVarFromWidgetContainerWidget_WidgetContainer_1.container.height;
            _container.width = UnknownVarFromWidgetContainerWidget_WidgetContainer_1.container.width;
         }
      }
      
      private function createWidgetContainer(param1:String) : WidgetContainer
      {
         var _loc3_:String = _landingView.getProperty("landing.view." + param1 + ".widget");
         var _loc2_:ILandingViewWidget = LandingViewWidgetType.getWidgetForType(_loc3_,_landingView);
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc2_ is ISlotAwareWidget)
         {
            ISlotAwareWidget(_loc2_).slot = UnknownVarFromWidgetContainerWidget_Int_1;
         }
         if(_loc2_ is UnknownIHabboFriendbarLandingviewInterfaces2)
         {
            UnknownIHabboFriendbarLandingviewInterfaces2(_loc2_).configurationCode = param1;
         }
         var _loc4_:WidgetContainer = new WidgetContainer(_loc2_,null,UnknownVarFromWidgetContainerWidget_CommonWidgetSettings_1,_container);
         UnknownVarFromWidgetContainerWidget_Dictionary_1[param1] = _loc4_;
         return _loc4_;
      }
      
      private function onTimingCode(param1:CurrentTimingCodeMessageEvent) : void
      {
         if(param1.getParser().schedulingStr == _schedulingStr && !disposed)
         {
            switchCurrentWidget(param1.getParser().code);
            refreshContent();
         }
      }
      
      private function switchCurrentWidget(param1:String) : void
      {
         if(param1 == "")
         {
            UnknownVarFromWidgetContainerWidget_WidgetContainer_1 = null;
            return;
         }
         var _loc2_:WidgetContainer = UnknownVarFromWidgetContainerWidget_Dictionary_1[param1];
         if(_loc2_ == null)
         {
            _loc2_ = createWidgetContainer(param1);
         }
         UnknownVarFromWidgetContainerWidget_WidgetContainer_1 = _loc2_;
      }
   }
}

