package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.UnknownIHabboFriendbarLandingviewInterfaces1;
   import com.sulake.habbo.friendbar.landingview.interfaces.UnknownIHabboFriendbarLandingviewInterfaces2;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements2;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.friendbar.landingview.widget.elements.TitleElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.elements.UnknownHabboFriendbarLandingviewWidgetElements1;
   
   public class GenericWidget implements ILandingViewWidget, ISlotAwareWidget, ISettingsAwareWidget, UnknownIHabboFriendbarLandingviewInterfaces2, UnknownIHabboFriendbarLandingviewInterfaces1
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromGenericWidget_Int_1:int;
      
      private var _configurationCode:String;
      
      private var UnknownVarFromGenericWidget_Map_1:Map;
      
      public function GenericWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         UnknownVarFromGenericWidget_Map_1 = new Map();
      }
      
      public static function configureLayout(param1:HabboLandingView, param2:int, param3:String, param4:IWindowController_1) : void
      {
         var _loc9_:Array = null;
         var _loc12_:String = null;
         var _loc11_:String = null;
         var _loc5_:String = getConf(param1,param2,param3,"layout");
         var _loc10_:Array = _loc5_.split(";");
         var _loc8_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param4.findChildByName("bitmap"));
         var _loc6_:IWindowModel = param4.findChildByName("content_container");
         _loc6_.x = isWideSlot(param2) ? 230 : 0;
         param4.width = isWideSlot(param2) ? param1.dynamicLayoutLeftPaneWidth : param1.dynamicLayoutRightPaneWidth;
         for each(var _loc7_ in _loc10_)
         {
            _loc9_ = _loc7_.split(",");
            _loc12_ = _loc9_[0];
            _loc11_ = _loc9_[1];
            switch(_loc12_)
            {
               case "bitmap.uri":
                  _loc8_.assetUri = _loc11_;
                  break;
               case "bitmap.width":
                  _loc8_.width = parseInt(_loc11_);
                  break;
               case "bitmap.height":
                  _loc8_.height = parseInt(_loc11_);
                  break;
               case "bitmap.x":
                  _loc8_.x = parseInt(_loc11_);
                  break;
               case "bitmap.y":
                  _loc8_.y = parseInt(_loc11_);
                  break;
               case "content.x":
                  _loc6_.x = parseInt(_loc11_);
                  break;
               case "content.y":
                  _loc6_.y = parseInt(_loc11_);
                  break;
               case "content.width":
                  _loc6_.width = parseInt(_loc11_);
                  break;
               case "container.height":
                  param4.height = Math.max(parseInt(_loc11_),param4.height);
                  break;
            }
         }
      }
      
      private static function getConf(param1:HabboLandingView, param2:int, param3:String, param4:String) : String
      {
         var _loc5_:String = param3 != null ? "landing.view." + param3 + "." + param4 : "landing.view.dynamic.slot." + param2 + "." + param4;
         return param1.getProperty(_loc5_);
      }
      
      private static function isWideSlot(param1:int) : Boolean
      {
         return param1 != 3 && param1 != 5;
      }
      
      public function set slot(param1:int) : void
      {
         UnknownVarFromGenericWidget_Int_1 = param1;
      }
      
      public function get configurationCode() : String
      {
         return _configurationCode;
      }
      
      public function set configurationCode(param1:String) : void
      {
         _configurationCode = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         for each(var _loc1_ in UnknownVarFromGenericWidget_Map_1)
         {
            if(_loc1_ is IComponentInterfaceQueue)
            {
               IComponentInterfaceQueue(_loc1_).dispose();
            }
         }
         UnknownVarFromGenericWidget_Map_1 = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("generic_widget"));
         configureContentColumn();
         configureLayout(_landingView,UnknownVarFromGenericWidget_Int_1,_configurationCode,_container);
      }
      
      public function getElementByName(param1:String) : IElementHandler
      {
         return UnknownVarFromGenericWidget_Map_1.getValue(param1) as IElementHandler;
      }
      
      private function configureContentColumn() : void
      {
         var _loc6_:Array = null;
         var _loc8_:String = null;
         var _loc1_:IElementHandler = null;
         var _loc9_:String = null;
         var _loc5_:IWindowModel = null;
         var _loc2_:String = getConf(_landingView,UnknownVarFromGenericWidget_Int_1,_configurationCode,"conf");
         var _loc7_:Array = _loc2_.split(";");
         if(_loc2_ == null || _loc2_ == "")
         {
            return;
         }
         var _loc4_:IItemListWindow = IItemListWindow(_container.findChildByName("content_container"));
         var _loc13_:int = 0;
         var _loc12_:* = _loc7_;
         while(true)
         {
            for each(var _loc3_ in _loc12_)
            {
               _loc6_ = _loc3_.split(",");
               _loc8_ = _loc6_[0];
               _loc1_ = UnknownHabboFriendbarLandingviewWidgetElements1.createHandler(_loc8_);
               _loc9_ = _loc1_ is ILayoutNameProvider ? ILayoutNameProvider(_loc1_).layoutName : "element_" + _loc8_;
               try
               {
                  _loc5_ = _landingView.getXmlWindow(_loc9_);
               }
               catch(e:Error)
               {
                  break;
               }
               if(_loc5_ == null)
               {
                  return;
               }
               if(_loc1_ != null)
               {
                  _loc1_.initialize(_landingView,_loc5_,_loc6_,this);
                  UnknownVarFromGenericWidget_Map_1.add(_loc8_,_loc1_);
               }
               if(_loc1_ is UnknownIHabboFriendbarLandingviewInterfacesElements1 && Boolean(UnknownIHabboFriendbarLandingviewInterfacesElements1(_loc1_).isFloating(isWideSlot(UnknownVarFromGenericWidget_Int_1))))
               {
                  if(_loc1_ is TitleElementHandler)
                  {
                     _loc5_.width = isWideSlot(UnknownVarFromGenericWidget_Int_1) ? _landingView.dynamicLayoutLeftPaneWidth : _landingView.dynamicLayoutRightPaneWidth;
                  }
                  _container.addChild(_loc5_);
               }
               else
               {
                  _loc4_.addListItem(_loc5_);
               }
            }
            return;
         }
      }
      
      public function refresh() : void
      {
         for each(var _loc1_ in UnknownVarFromGenericWidget_Map_1)
         {
            _loc1_.refresh();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      public function disable() : void
      {
         for each(var _loc1_ in UnknownVarFromGenericWidget_Map_1)
         {
            if(_loc1_ is UnknownIHabboFriendbarLandingviewInterfacesElements2)
            {
               UnknownIHabboFriendbarLandingviewInterfacesElements2(_loc1_).disable();
            }
         }
      }
   }
}

