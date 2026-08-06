package com.sulake.habbo.freeflowchat.history.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class ChatHistoryScrollBar
   {
      public static const RIGHT_MARGIN:int = 0;
      
      private var UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1:ChatHistoryScrollView;
      
      private var _displayObject:Sprite;
      
      private var _background:Sprite;
      
      private var UnknownVarFromChatHistoryScrollBar_Sprite_1:Sprite;
      
      private var UnknownVarFromChatHistoryScrollBar_Int_1:int;
      
      private var UnknownVarFromChatHistoryScrollBar_Int_2:int;
      
      private var UnknownVarFromChatHistoryScrollBar_Stage_1:Stage;
      
      public function ChatHistoryScrollBar(param1:ChatHistoryScrollView, param2:HabboFreeFlowChat)
      {
         super();
         UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1 = param1;
         UnknownVarFromChatHistoryScrollBar_Sprite_1 = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2,2,1,1),param2.assets.getAssetByName("scrollbar_thumb").content as BitmapData);
         UnknownVarFromChatHistoryScrollBar_Sprite_1.x = 2;
         UnknownVarFromChatHistoryScrollBar_Sprite_1.y = 2;
         _background = HabboFreeFlowChat.create9SliceSprite(new Rectangle(2,2,5,5),param2.assets.getAssetByName("scrollbar_back").content as BitmapData);
         _displayObject = new Sprite();
         _displayObject.addChild(_background);
         _displayObject.addChild(UnknownVarFromChatHistoryScrollBar_Sprite_1);
         UnknownVarFromChatHistoryScrollBar_Sprite_1.addEventListener("addedToStage",onAddedToStage);
         UnknownVarFromChatHistoryScrollBar_Sprite_1.addEventListener("removedFromStage",onRemovedFromStage);
         UnknownVarFromChatHistoryScrollBar_Sprite_1.addEventListener("mouseDown",mouseDownEventHandler);
      }
      
      public function set height(param1:int) : void
      {
         _background.height = param1;
         updateThumbTrack();
      }
      
      public function get displayObject() : Sprite
      {
         return _displayObject;
      }
      
      public function updateThumbTrack() : void
      {
         if(UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.bufferHeight <= 0)
         {
            UnknownVarFromChatHistoryScrollBar_Sprite_1.height = Math.max(5,_background.height - 4);
            UnknownVarFromChatHistoryScrollBar_Sprite_1.y = 2;
            return;
         }
         var _loc1_:int = UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.topY + (UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.viewPort.height - _background.height);
         UnknownVarFromChatHistoryScrollBar_Sprite_1.height = Math.min(_background.height - 4,Math.max(5,int((_background.height - 4) * (_background.height / UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.bufferHeight))));
         UnknownVarFromChatHistoryScrollBar_Sprite_1.y = Math.min(_background.height - 2 - UnknownVarFromChatHistoryScrollBar_Sprite_1.height,Math.max(2,int((_background.height - 4) * (Math.max(1,_loc1_) / UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.bufferHeight) - UnknownVarFromChatHistoryScrollBar_Sprite_1.height / 2)));
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         UnknownVarFromChatHistoryScrollBar_Stage_1 = UnknownVarFromChatHistoryScrollBar_Sprite_1.stage;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         UnknownVarFromChatHistoryScrollBar_Stage_1 = null;
      }
      
      private function mouseDownEventHandler(param1:Event) : void
      {
         UnknownVarFromChatHistoryScrollBar_Int_1 = MouseEvent(param1).stageY;
         UnknownVarFromChatHistoryScrollBar_Int_2 = UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.topY;
         UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.beginUserScrollInteraction();
         UnknownVarFromChatHistoryScrollBar_Stage_1.addEventListener("mouseUp",mouseDragEventHandler);
         UnknownVarFromChatHistoryScrollBar_Stage_1.addEventListener("mouseMove",mouseDragEventHandler);
         param1.stopImmediatePropagation();
      }
      
      private function mouseDragEventHandler(param1:Event) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:MouseEvent = MouseEvent(param1);
         switch(_loc3_.type)
         {
            case "mouseMove":
               _loc4_ = UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.bufferHeight / _background.height;
               _loc2_ = (_loc3_.stageY - UnknownVarFromChatHistoryScrollBar_Int_1) * _loc4_;
               UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.topY = UnknownVarFromChatHistoryScrollBar_Int_2 + _loc2_;
               break;
            case "mouseUp":
               endScroll();
         }
         param1.stopImmediatePropagation();
      }
      
      public function endScroll() : void
      {
         cancelScroll();
         UnknownVarFromChatHistoryScrollBar_ChatHistoryScrollView_1.startSpringbackIfNeeded();
      }
      
      public function cancelScroll() : void
      {
         if(UnknownVarFromChatHistoryScrollBar_Stage_1)
         {
            UnknownVarFromChatHistoryScrollBar_Stage_1.removeEventListener("mouseUp",mouseDragEventHandler);
            UnknownVarFromChatHistoryScrollBar_Stage_1.removeEventListener("mouseMove",mouseDragEventHandler);
         }
      }
   }
}

