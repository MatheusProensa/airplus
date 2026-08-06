package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.IResizeAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.UnknownIHabboFriendbarLandingviewInterfaces1;
   
   public class WidgetContainer implements IComponentInterfaceQueue
   {
      private var UnknownVarFromWidgetContainer_ILandingViewWidget_1:ILandingViewWidget;
      
      private var _placeholderName:String;
      
      private var UnknownVarFromWidgetContainer_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromWidgetContainer_Boolean_1:Boolean;
      
      private var UnknownVarFromWidgetContainer_CommonWidgetSettings_1:CommonWidgetSettings;
      
      public function WidgetContainer(param1:ILandingViewWidget, param2:String, param3:CommonWidgetSettings, param4:IWindowController_1 = null)
      {
         super();
         UnknownVarFromWidgetContainer_ILandingViewWidget_1 = param1;
         _placeholderName = param2;
         UnknownVarFromWidgetContainer_CommonWidgetSettings_1 = param3;
         UnknownVarFromWidgetContainer_IWindowController_1_1 = param4;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromWidgetContainer_ILandingViewWidget_1)
         {
            UnknownVarFromWidgetContainer_ILandingViewWidget_1.dispose();
            UnknownVarFromWidgetContainer_ILandingViewWidget_1 = null;
         }
         if(UnknownVarFromWidgetContainer_CommonWidgetSettings_1)
         {
            UnknownVarFromWidgetContainer_CommonWidgetSettings_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromWidgetContainer_ILandingViewWidget_1 == null && UnknownVarFromWidgetContainer_CommonWidgetSettings_1 == null;
      }
      
      public function refresh(param1:IWindowController_1) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:IWindowController_1 = IWindowController_1(param1.findChildByName("content_background"));
         if(!UnknownVarFromWidgetContainer_Boolean_1)
         {
            UnknownVarFromWidgetContainer_Boolean_1 = true;
            if(_placeholderName != null)
            {
               _loc3_ = _loc2_.getChildByName(_placeholderName);
               if(_loc3_ == null)
               {
                  return;
               }
               UnknownVarFromWidgetContainer_ILandingViewWidget_1.initialize();
               _loc2_.addChildAt(UnknownVarFromWidgetContainer_ILandingViewWidget_1.container,_loc2_.getChildIndex(_loc3_));
               UnknownVarFromWidgetContainer_ILandingViewWidget_1.container.x = _loc3_.x;
               UnknownVarFromWidgetContainer_ILandingViewWidget_1.container.y = _loc3_.y;
               _loc2_.removeChild(_loc3_);
               _loc3_.dispose();
            }
            else
            {
               if(!(UnknownVarFromWidgetContainer_IWindowController_1_1 != null && UnknownVarFromWidgetContainer_ILandingViewWidget_1 != null))
               {
                  return;
               }
               UnknownVarFromWidgetContainer_ILandingViewWidget_1.initialize();
               UnknownVarFromWidgetContainer_IWindowController_1_1.addChild(UnknownVarFromWidgetContainer_ILandingViewWidget_1.container);
            }
         }
         if(UnknownVarFromWidgetContainer_ILandingViewWidget_1.container != null)
         {
            if(UnknownVarFromWidgetContainer_ILandingViewWidget_1 is ISettingsAwareWidget && UnknownVarFromWidgetContainer_CommonWidgetSettings_1 != null)
            {
               ISettingsAwareWidget(UnknownVarFromWidgetContainer_ILandingViewWidget_1).settings = UnknownVarFromWidgetContainer_CommonWidgetSettings_1;
            }
            UnknownVarFromWidgetContainer_ILandingViewWidget_1.refresh();
         }
      }
      
      public function get container() : IWindowModel
      {
         return UnknownVarFromWidgetContainer_ILandingViewWidget_1.container;
      }
      
      public function windowResized() : void
      {
         if(UnknownVarFromWidgetContainer_ILandingViewWidget_1 != null && UnknownVarFromWidgetContainer_ILandingViewWidget_1.container != null && UnknownVarFromWidgetContainer_ILandingViewWidget_1 is IResizeAwareWidget)
         {
            IResizeAwareWidget(UnknownVarFromWidgetContainer_ILandingViewWidget_1).windowResized();
         }
      }
      
      public function disable() : void
      {
         if(UnknownVarFromWidgetContainer_ILandingViewWidget_1 != null && UnknownVarFromWidgetContainer_ILandingViewWidget_1.container != null && UnknownVarFromWidgetContainer_ILandingViewWidget_1 is UnknownIHabboFriendbarLandingviewInterfaces1)
         {
            UnknownIHabboFriendbarLandingviewInterfaces1(UnknownVarFromWidgetContainer_ILandingViewWidget_1).disable();
         }
      }
   }
}

