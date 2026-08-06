package com.sulake.habbo.catalog.viewer
{
   import flash.utils.Dictionary;
   
   public class PageLocalization implements IPageLocalization
   {
      public static const HEADER_IMAGE:String = "catalog.header.image";
      
      public static const UnknownConstFromPageLocalization_String_1:String = "catalog.header.icon";
      
      public static const HEADER_TITLE:String = "catalog.header.title";
      
      public static const UnknownConstFromPageLocalization_String_2:String = "catalog.header.description";
      
      private static const DEFAULT_TEXT_FIELDS:Array = ["catalog.header.description","ctlg_description","ctlg_special_txt","ctlg_text_1","ctlg_text_2"];
      
      private static const DEFAULT_IMAGE_FIELDS:Array = ["catalog.header.image","ctlg_teaserimg_1","ctlg_special_img","ctlg_teaserimg_2","ctlg_teaserimg_3"];
      
      private static const LAYOUTS_IMAGE_FIELDS:Dictionary = new Dictionary();
      
      private static const LAYOUTS_TEXT_FIELDS:Dictionary = new Dictionary();
      
      private static const LAYOUT_LINKS:Dictionary = new Dictionary();
      
      LAYOUTS_IMAGE_FIELDS["frontpage4"] = ["catalog.header.image","ctlg_teaserimg_1"];
      LAYOUTS_TEXT_FIELDS["camera1"] = ["catalog.header.description","ctlg_text_1"];
      LAYOUTS_TEXT_FIELDS["presents"] = ["catalog.header.description","ctlg_text1"];
      LAYOUTS_TEXT_FIELDS["pets"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["pets2"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["pets3"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3"];
      LAYOUTS_TEXT_FIELDS["info_rentables"] = ["catalog.header.description","ctlg_text_1","ctlg_text_2","ctlg_text_3","ctlg_text_4","ctlg_text_5"];
      LAYOUTS_TEXT_FIELDS["info_duckets"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["info_loyalty"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["trophies"] = ["trophy.description","trophy.enscription"];
      LAYOUTS_TEXT_FIELDS["frontpage4"] = ["ctlg_txt1","ctlg_txt2"];
      LAYOUTS_TEXT_FIELDS["builders_club_frontpage"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["builders_club_addons"] = ["ctlg_description"];
      LAYOUTS_TEXT_FIELDS["builders_club_loyalty"] = ["ctlg_description"];
      LAYOUT_LINKS["club_buy"] = ["club_link"];
      LAYOUT_LINKS["mad_money"] = ["ctlg_madmoney_button"];
      LAYOUT_LINKS["monkey"] = ["ctlg_teaserimg_1_region","ctlg_special_img_region"];
      LAYOUT_LINKS["niko"] = ["ctlg_teaserimg_1_region","ctlg_special_img_region"];
      LAYOUT_LINKS["pets3"] = ["ctlg_text_3"];
      
      private var _images:Array;
      
      private var UnknownVarFromPageLocalization_Array_1:Array;
      
      public function PageLocalization(param1:Array, param2:Array)
      {
         super();
         _images = param1;
         UnknownVarFromPageLocalization_Array_1 = param2;
      }
      
      public function get imageCount() : int
      {
         return _images.length;
      }
      
      public function get textCount() : int
      {
         return UnknownVarFromPageLocalization_Array_1.length;
      }
      
      public function dispose() : void
      {
         _images = null;
         UnknownVarFromPageLocalization_Array_1 = null;
      }
      
      public function hasLinks(param1:String) : Boolean
      {
         return LAYOUT_LINKS[param1] != null;
      }
      
      public function getLinks(param1:String) : Array
      {
         return LAYOUT_LINKS[param1];
      }
      
      public function getTextElementName(param1:int, param2:String) : String
      {
         var _loc3_:Array = LAYOUTS_TEXT_FIELDS[param2];
         if(_loc3_ == null)
         {
            _loc3_ = DEFAULT_TEXT_FIELDS;
         }
         if(param1 < _loc3_.length)
         {
            return _loc3_[param1];
         }
         return "";
      }
      
      public function getImageElementName(param1:int, param2:String) : String
      {
         var _loc3_:Array = LAYOUTS_IMAGE_FIELDS[param2];
         if(_loc3_ == null)
         {
            _loc3_ = DEFAULT_IMAGE_FIELDS;
         }
         if(param1 < _loc3_.length)
         {
            return _loc3_[param1];
         }
         return "";
      }
      
      public function getTextElementContent(param1:int) : String
      {
         if(param1 < UnknownVarFromPageLocalization_Array_1.length)
         {
            return UnknownVarFromPageLocalization_Array_1[param1];
         }
         return "";
      }
      
      public function getImageElementContent(param1:int) : String
      {
         if(param1 < _images.length)
         {
            return _images[param1];
         }
         return "";
      }
      
      public function getColorUintFromText(param1:int) : uint
      {
         var _loc2_:String = null;
         if(param1 < UnknownVarFromPageLocalization_Array_1.length)
         {
            _loc2_ = String(UnknownVarFromPageLocalization_Array_1[param1]).replace("#","0x");
            return uint(Number(_loc2_));
         }
         return 0;
      }
   }
}

