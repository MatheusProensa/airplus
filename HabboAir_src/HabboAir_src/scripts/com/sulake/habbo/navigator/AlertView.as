package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements IComponentInterfaceQueue
   {
      private static var UnknownVarFromAlertView_Dictionary_1:Dictionary = new Dictionary();
      
      private var _navigator:IHabboNavigator_2;
      
      protected var UnknownVarFromAlertView_IFrameController_1:IFrameController;
      
      protected var _xmlFileName:String;
      
      protected var UnknownVarFromAlertView_String_1:String;
      
      protected var _disposed:Boolean;
      
      public function AlertView(param1:IHabboNavigator_2, param2:String, param3:String = null)
      {
         super();
         _navigator = param1;
         _xmlFileName = param2;
         UnknownVarFromAlertView_String_1 = param3;
      }
      
      public static function findAlertView(param1:IWindowModel) : AlertView
      {
         if(UnknownVarFromAlertView_Dictionary_1 != null)
         {
            for each(var _loc2_ in UnknownVarFromAlertView_Dictionary_1)
            {
               if(_loc2_.UnknownVarFromAlertView_IFrameController_1 == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function show() : void
      {
         var _loc2_:AlertView = UnknownVarFromAlertView_Dictionary_1[_xmlFileName] as AlertView;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         UnknownVarFromAlertView_IFrameController_1 = getAlertWindow();
         if(UnknownVarFromAlertView_String_1 != null)
         {
            UnknownVarFromAlertView_IFrameController_1.caption = UnknownVarFromAlertView_String_1;
         }
         setupAlertWindow(UnknownVarFromAlertView_IFrameController_1);
         var _loc1_:Rectangle = Util.getLocationRelativeTo(UnknownVarFromAlertView_IFrameController_1.desktop,UnknownVarFromAlertView_IFrameController_1.width,UnknownVarFromAlertView_IFrameController_1.height);
         UnknownVarFromAlertView_IFrameController_1.x = _loc1_.x;
         UnknownVarFromAlertView_IFrameController_1.y = _loc1_.y;
         UnknownVarFromAlertView_Dictionary_1[_xmlFileName] = this;
         UnknownVarFromAlertView_IFrameController_1.activate();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromAlertView_Dictionary_1[_xmlFileName] == this)
         {
            UnknownVarFromAlertView_Dictionary_1[_xmlFileName] = null;
         }
         _disposed = true;
         if(UnknownVarFromAlertView_IFrameController_1 != null)
         {
            UnknownVarFromAlertView_IFrameController_1.destroy();
            UnknownVarFromAlertView_IFrameController_1 = null;
         }
         _navigator = null;
      }
      
      internal function setupAlertWindow(param1:IFrameController) : void
      {
      }
      
      internal function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function getAlertWindow() : IFrameController
      {
         var _loc2_:IFrameController = _navigator.getXmlWindow(this._xmlFileName,2) as IFrameController;
         var _loc1_:IWindowModel = _loc2_.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
         return _loc2_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get navigator() : IHabboNavigator_2
      {
         return _navigator;
      }
   }
}

