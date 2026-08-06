package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MySanctionStatusMessageParser implements IMessageParser
   {
      private var _sanctions:Array;
      
      public function MySanctionStatusMessageParser()
      {
         super();
         _sanctions = [];
      }
      
      public function flush() : Boolean
      {
         _sanctions = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc2_:SanctionDTO = null;
         _sanctions = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new SanctionDTO();
            _loc2_.UnknownVarFromSanctionDTO_SanctionType_1 = readSanctionType(param1);
            _loc2_.UnknownVarFromSanctionDTO_String_1 = param1.readString();
            _loc2_.UnknownVarFromSanctionDTO_Boolean_1 = param1.readBoolean();
            _loc2_.UnknownVarFromSanctionDTO_Int_1 = param1.readInteger();
            _loc2_.UnknownVarFromSanctionDTO_SanctionType_2 = readSanctionType(param1);
            _sanctions.push(_loc2_);
            _loc4_++;
         }
         return true;
      }
      
      private function readSanctionType(param1:IMessageDataWrapper) : SanctionType
      {
         var _loc2_:SanctionType = new SanctionType();
         _loc2_.name = param1.readString();
         _loc2_.UnknownVarFromSanctionType_Int_1 = param1.readInteger();
         _loc2_.UnknownVarFromSanctionType_Int_2 = param1.readInteger();
         return _loc2_;
      }
      
      public function get sanctions() : Array
      {
         return _sanctions;
      }
   }
}

