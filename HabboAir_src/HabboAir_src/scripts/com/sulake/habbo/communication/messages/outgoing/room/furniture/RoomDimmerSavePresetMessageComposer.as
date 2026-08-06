package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerSavePresetMessageComposer implements IMessageComposer
   {
      private var _presetNumber:int;
      
      private var UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_1:int;
      
      private var UnknownVarFromRoomDimmerSavePresetMessageComposer_String_1:String;
      
      private var UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_2:int;
      
      private var UnknownVarFromRoomDimmerSavePresetMessageComposer_Boolean_1:Boolean;
      
      private var UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_3:int;
      
      public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int)
      {
         super();
         _presetNumber = param1;
         UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_1 = param2;
         UnknownVarFromRoomDimmerSavePresetMessageComposer_String_1 = param3;
         UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_2 = param4;
         UnknownVarFromRoomDimmerSavePresetMessageComposer_Boolean_1 = param5;
         UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_3 = param6;
      }
      
      public function getMessageArray() : Array
      {
         return [_presetNumber,UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_1,UnknownVarFromRoomDimmerSavePresetMessageComposer_String_1,UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_2,UnknownVarFromRoomDimmerSavePresetMessageComposer_Boolean_1,false,UnknownVarFromRoomDimmerSavePresetMessageComposer_Int_3];
      }
      
      public function dispose() : void
      {
      }
   }
}

