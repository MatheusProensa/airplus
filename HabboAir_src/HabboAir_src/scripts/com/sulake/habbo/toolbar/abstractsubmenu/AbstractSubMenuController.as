package com.sulake.habbo.toolbar.abstractsubmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.BottomBarLeft;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import flash.geom.Rectangle;
   
   public class AbstractSubMenuController implements IAbstractSubMenuController
   {
      private var _toolbar:HabboToolbar;
      
      private var _toolbarView:BottomBarLeft;
      
      private var _window:IWindowController_1;
      
      private var _unseenItemCounters:Map;
      
      private var UnknownVarFromAbstractSubMenuController_String_1:String;
      
      private var _disposed:Boolean;
      
      public function AbstractSubMenuController(param1:HabboToolbar, param2:BottomBarLeft, param3:String, param4:String)
      {
         super();
         _unseenItemCounters = new Map();
         _toolbar = param1;
         _toolbarView = param2;
         UnknownVarFromAbstractSubMenuController_String_1 = param4;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var _loc5_:XmlAsset = _toolbar.assets.getAssetByName(param3) as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc5_.content as XML,2) as IWindowController_1;
         _window.visible = false;
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc6_:IRegionWindow = null;
         var _loc5_:IStaticBitmapWrapperWindow = null;
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:ITextWindow = null;
         if(param2 is IRegionWindow)
         {
            _loc6_ = param2 as IRegionWindow;
            _loc5_ = _loc6_.findChildByName(param2.name + "_icon_color") as IStaticBitmapWrapperWindow;
            _loc3_ = _loc6_.findChildByName(param2.name + "_icon_grey") as IStaticBitmapWrapperWindow;
            _loc4_ = _loc6_.findChildByName("field_text") as ITextWindow;
            switch(param1.type)
            {
               case "WME_OVER":
                  if(_loc5_ != null && _loc3_ != null)
                  {
                     _loc5_.visible = true;
                     _loc3_.visible = false;
                     if(_loc4_ != null)
                     {
                        _loc4_.textColor = 2215924;
                     }
                  }
                  break;
               case "WME_OUT":
                  if(_loc5_ != null && _loc3_ != null)
                  {
                     _loc5_.visible = false;
                     _loc3_.visible = true;
                     if(_loc4_ != null)
                     {
                        _loc4_.textColor = 16777215;
                     }
                  }
                  break;
               case "WME_CLICK":
                  _window.visible = false;
                  if(_toolbar != null)
                  {
                     onSubMenuItemClick(param2.name);
                  }
            }
         }
      }
      
      protected function onSubMenuItemClick(param1:String) : void
      {
      }
      
      protected function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         if(param1.iconId == UnknownVarFromAbstractSubMenuController_String_1)
         {
            toggleVisibility();
         }
         else
         {
            _window.visible = false;
         }
      }
      
      public function toggleVisibility() : void
      {
         _window.visible = !_window.visible;
         reposition();
      }
      
      public function reposition() : void
      {
         _window.x = 3;
         _window.y = _toolbarView.window.top - _window.height;
      }
      
      public function getIconPosition(param1:String) : Rectangle
      {
         var _loc2_:Rectangle = null;
         var _loc3_:IWindowModel = _window.findChildByName(param1);
         if(_loc3_)
         {
            _loc2_ = _loc3_.rectangle;
            _loc2_.x += _window.x + _loc3_.width / 2;
            _loc2_.y += _window.y + _loc3_.height / 2;
            _window.visible = true;
         }
         return _loc2_;
      }
      
      public function getIcon(param1:String) : IWindowModel
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_)
         {
            _window.visible = true;
         }
         return _loc2_;
      }
      
      public function getUnseenItemCounter(param1:String) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = null;
         var _loc4_:* = param1;
         if(!_loc4_)
         {
            Logger.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowController_1 = _unseenItemCounters.getValue(param1) as IWindowController_1;
         if(!_loc3_)
         {
            _loc3_ = _toolbar.windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowController_1;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 5;
               _loc3_.y = 5;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:IWindowController_1 = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      protected function get toolbar() : HabboToolbar
      {
         return _toolbar;
      }
      
      protected function get toolbarView() : BottomBarLeft
      {
         return _toolbarView;
      }
      
      protected function get window() : IWindowController_1
      {
         return _window;
      }
      
      protected function get unseenItemCounters() : Map
      {
         return _unseenItemCounters;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         _toolbarView = null;
         _toolbar = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

