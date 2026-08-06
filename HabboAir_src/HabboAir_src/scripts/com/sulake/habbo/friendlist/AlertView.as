package com.sulake.habbo.friendlist
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements IComponentInterfaceQueue
   {
      private static var UnknownVarFromAlertView_Dictionary_1:Dictionary = new Dictionary();
      
      private var _friendList:HabboFriendList;
      
      private var UnknownVarFromAlertView_IFrameController_1:IFrameController;
      
      private var _xmlFileName:String;
      
      private var UnknownVarFromAlertView_String_1:String;
      
      private var _disposed:Boolean;
      
      public function AlertView(param1:HabboFriendList, param2:String, param3:String = null)
      {
         super();
         _friendList = param1;
         _xmlFileName = param2;
         UnknownVarFromAlertView_String_1 = param3;
      }
      
      public function show() : void
      {
         var _loc1_:IFrameController = IFrameController(UnknownVarFromAlertView_Dictionary_1[_xmlFileName]);
         if(_loc1_ != null)
         {
            _loc1_.dispose();
         }
         UnknownVarFromAlertView_IFrameController_1 = getAlert();
         if(UnknownVarFromAlertView_String_1 != null)
         {
            UnknownVarFromAlertView_IFrameController_1.caption = UnknownVarFromAlertView_String_1;
         }
         setupContent(UnknownVarFromAlertView_IFrameController_1.content);
         var _loc2_:Rectangle = Util.getLocationRelativeTo(_friendList.view.mainWindow,UnknownVarFromAlertView_IFrameController_1.width,UnknownVarFromAlertView_IFrameController_1.height);
         UnknownVarFromAlertView_IFrameController_1.x = _loc2_.x;
         UnknownVarFromAlertView_IFrameController_1.y = _loc2_.y;
         UnknownVarFromAlertView_Dictionary_1[_xmlFileName] = UnknownVarFromAlertView_IFrameController_1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromAlertView_IFrameController_1 != null)
         {
            UnknownVarFromAlertView_IFrameController_1.destroy();
            UnknownVarFromAlertView_IFrameController_1 = null;
         }
         _friendList = null;
      }
      
      internal function setupContent(param1:IWindowController_1) : void
      {
      }
      
      internal function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function getAlert() : IFrameController
      {
         var _loc1_:IFrameController = IFrameController(_friendList.getXmlWindow(this._xmlFileName));
         var _loc2_:IWindowModel = _loc1_.findChildByTag("close");
         _loc2_.procedure = onClose;
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get friendList() : HabboFriendList
      {
         return _friendList;
      }
   }
}

