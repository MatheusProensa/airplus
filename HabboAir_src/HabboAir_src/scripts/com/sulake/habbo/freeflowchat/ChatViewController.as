package com.sulake.habbo.freeflowchat
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
   import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class ChatViewController implements IComponentInterfaceQueue
   {
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var UnknownVarFromChatViewController_Stage_1:Stage;
      
      private var UnknownVarFromChatViewController_HabboFreeFlowChat_1:HabboFreeFlowChat;
      
      private var UnknownVarFromChatViewController_ChatFlowViewer_1:ChatFlowViewer;
      
      private var _pulldown:ChatHistoryTray;
      
      private var _flowViewerDisplayObject:DisplayObject;
      
      private var _pulldownDisplayObject:DisplayObject;
      
      public function ChatViewController(param1:HabboFreeFlowChat, param2:ChatFlowViewer, param3:ChatHistoryTray)
      {
         super();
         UnknownVarFromChatViewController_HabboFreeFlowChat_1 = param1;
         UnknownVarFromChatViewController_ChatFlowViewer_1 = param2;
         _pulldown = param3;
         _flowViewerDisplayObject = UnknownVarFromChatViewController_ChatFlowViewer_1.rootDisplayObject;
         _pulldownDisplayObject = _pulldown.rootDisplayObject;
         _rootDisplayObject = new Sprite();
         _rootDisplayObject.addChild(_flowViewerDisplayObject);
         _rootDisplayObject.addChild(_pulldownDisplayObject);
         _rootDisplayObject.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function dispose() : void
      {
         if(_rootDisplayObject)
         {
            if(UnknownVarFromChatViewController_Stage_1)
            {
               UnknownVarFromChatViewController_Stage_1.removeEventListener("resize",onStageResized);
            }
            _rootDisplayObject.removeChild(_pulldownDisplayObject);
            _rootDisplayObject.removeChild(_flowViewerDisplayObject);
            _rootDisplayObject.removeEventListener("addedToStage",onAddedToStage);
            _rootDisplayObject = null;
            _pulldownDisplayObject = null;
            _flowViewerDisplayObject = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null;
      }
      
      public function get rootDisplayObject() : DisplayObject
      {
         return _rootDisplayObject;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         UnknownVarFromChatViewController_Stage_1 = _rootDisplayObject.stage;
         UnknownVarFromChatViewController_Stage_1.addEventListener("resize",onStageResized);
         _pulldown.resize(UnknownVarFromChatViewController_Stage_1.stageWidth,UnknownVarFromChatViewController_Stage_1.stageHeight);
      }
      
      private function onStageResized(param1:Event) : void
      {
         _pulldown.resize(UnknownVarFromChatViewController_Stage_1.stageWidth,UnknownVarFromChatViewController_Stage_1.stageHeight);
         UnknownVarFromChatViewController_ChatFlowViewer_1.resize(UnknownVarFromChatViewController_Stage_1.stageWidth,UnknownVarFromChatViewController_Stage_1.stageHeight);
      }
   }
}

