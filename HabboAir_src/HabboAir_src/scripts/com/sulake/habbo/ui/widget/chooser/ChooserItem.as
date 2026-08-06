package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.habbo.utils.FurniId;
   
   public class ChooserItem
   {
      private var _id:int;
      
      private var _category:int;
      
      private var _name:String;
      
      private var UnknownVarFromChooserItem_String_1:String;
      
      private var _type:int;
      
      private var _lowerCaseName:String;
      
      public function ChooserItem(param1:int, param2:int, param3:String, param4:String = null, param5:int = 0)
      {
         super();
         _id = param1;
         _category = param2;
         _name = param3;
         UnknownVarFromChooserItem_String_1 = param4;
         _type = param5;
         _lowerCaseName = _name.toLowerCase();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get owner() : String
      {
         if(FurniId.isBuilderClubId(_id))
         {
            return "Builders Club";
         }
         if(FurniId.isTempId(_id))
         {
            return "Temp (Wired)";
         }
         return UnknownVarFromChooserItem_String_1;
      }
      
      public function get lowerCaseName() : String
      {
         return _lowerCaseName;
      }
   }
}

