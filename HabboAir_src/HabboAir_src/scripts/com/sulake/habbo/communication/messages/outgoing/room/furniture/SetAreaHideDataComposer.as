package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetAreaHideDataComposer implements IMessageComposer
   {
      private var UnknownVarFromSetAreaHideDataComposer_Int_1:int;
      
      private var UnknownVarFromSetAreaHideDataComposer_Int_2:int;
      
      private var UnknownVarFromSetAreaHideDataComposer_Int_3:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var UnknownVarFromSetAreaHideDataComposer_Boolean_1:Boolean;
      
      private var UnknownVarFromSetAreaHideDataComposer_Boolean_2:Boolean;
      
      private var UnknownVarFromSetAreaHideDataComposer_Boolean_3:Boolean;
      
      public function SetAreaHideDataComposer(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:Boolean, param8:Boolean)
      {
         super();
         UnknownVarFromSetAreaHideDataComposer_Int_1 = param1;
         UnknownVarFromSetAreaHideDataComposer_Int_2 = param2;
         UnknownVarFromSetAreaHideDataComposer_Int_3 = param3;
         _width = param4;
         _length = param5;
         UnknownVarFromSetAreaHideDataComposer_Boolean_1 = param6;
         UnknownVarFromSetAreaHideDataComposer_Boolean_2 = param7;
         UnknownVarFromSetAreaHideDataComposer_Boolean_3 = param8;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetAreaHideDataComposer_Int_1,UnknownVarFromSetAreaHideDataComposer_Int_2,UnknownVarFromSetAreaHideDataComposer_Int_3,_width,_length,UnknownVarFromSetAreaHideDataComposer_Boolean_1,UnknownVarFromSetAreaHideDataComposer_Boolean_2,UnknownVarFromSetAreaHideDataComposer_Boolean_3];
      }
      
      public function dispose() : void
      {
      }
   }
}

