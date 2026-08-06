package com.sulake.habbo.room.object.visualization.pet
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ExperienceData
   {
      private var _image:BitmapData;
      
      private var UnknownVarFromExperienceData_Boolean_1:Boolean;
      
      private var UnknownVarFromExperienceData_BitmapData_1:BitmapData;
      
      private var _amount:int = -1;
      
      private var _alpha:int;
      
      public function ExperienceData(param1:BitmapData, param2:Boolean = true)
      {
         super();
         _image = param1;
         UnknownVarFromExperienceData_Boolean_1 = param2;
         if(_image != null)
         {
            UnknownVarFromExperienceData_BitmapData_1 = _image.clone();
         }
         setExperience(0);
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromExperienceData_BitmapData_1)
         {
            UnknownVarFromExperienceData_BitmapData_1.dispose();
            UnknownVarFromExperienceData_BitmapData_1 = null;
         }
         if(_image != null)
         {
            if(UnknownVarFromExperienceData_Boolean_1)
            {
               _image.dispose();
            }
            _image = null;
         }
      }
      
      public function get alpha() : int
      {
         return _alpha;
      }
      
      public function set alpha(param1:int) : void
      {
         _alpha = param1;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function setExperience(param1:int) : void
      {
         if(_amount == param1 || _image == null)
         {
            return;
         }
         _image.copyPixels(UnknownVarFromExperienceData_BitmapData_1,UnknownVarFromExperienceData_BitmapData_1.rect,new Point(0,0));
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = "Volter";
         _loc2_.color = 16777215;
         _loc2_.size = 9;
         var _loc3_:TextField = new TextField();
         _loc3_.embedFonts = true;
         _loc3_.width = 30;
         _loc3_.height = 12;
         _loc3_.background = true;
         _loc3_.backgroundColor = 3871388928;
         _loc3_.defaultTextFormat = _loc2_;
         _loc3_.text = "+" + param1;
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(15,19);
         _image.draw(_loc3_,_loc4_);
      }
   }
}

