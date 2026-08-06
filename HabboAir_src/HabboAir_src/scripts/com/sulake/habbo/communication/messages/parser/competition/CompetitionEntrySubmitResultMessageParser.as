package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class CompetitionEntrySubmitResultMessageParser implements IMessageParser
   {
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_2:int = 1;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_3:int = 2;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_4:int = 3;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_5:int = 4;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_6:int = 5;
      
      public static const UnknownConstFromCompetitionEntrySubmitResultMessageParser_Int_7:int = 6;
      
      private var _goalId:int;
      
      private var _goalCode:String;
      
      private var _result:int;
      
      private var _requiredFurnis:Array;
      
      private var UnknownVarFromCompetitionEntrySubmitResultMessageParser_Dictionary_1:Dictionary;
      
      public function CompetitionEntrySubmitResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _requiredFurnis = null;
         UnknownVarFromCompetitionEntrySubmitResultMessageParser_Dictionary_1 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _goalId = param1.readInteger();
         _goalCode = param1.readString();
         _result = param1.readInteger();
         _requiredFurnis = [];
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _requiredFurnis.push(param1.readString());
            _loc2_++;
         }
         UnknownVarFromCompetitionEntrySubmitResultMessageParser_Dictionary_1 = new Dictionary();
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            UnknownVarFromCompetitionEntrySubmitResultMessageParser_Dictionary_1[param1.readString()] = "";
            _loc2_++;
         }
         return true;
      }
      
      public function get goalId() : int
      {
         return _goalId;
      }
      
      public function get goalCode() : String
      {
         return _goalCode;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function get requiredFurnis() : Array
      {
         return _requiredFurnis;
      }
      
      public function isMissing(param1:String) : Boolean
      {
         return UnknownVarFromCompetitionEntrySubmitResultMessageParser_Dictionary_1[param1] != null;
      }
   }
}

