package deng.fzip
{
   import flash.events.*;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.*;
   
   public class FZip extends EventDispatcher
   {
      internal static const SIG_CENTRAL_FILE_HEADER:uint = 33639248;
      
      internal static const SIG_SPANNING_MARKER:uint = 808471376;
      
      internal static const SIG_LOCAL_FILE_HEADER:uint = 67324752;
      
      internal static const SIG_DIGITAL_SIGNATURE:uint = 84233040;
      
      internal static const SIG_END_OF_CENTRAL_DIRECTORY:uint = 101010256;
      
      internal static const SIG_ZIP64_END_OF_CENTRAL_DIRECTORY:uint = 101075792;
      
      internal static const SIG_ZIP64_END_OF_CENTRAL_DIRECTORY_LOCATOR:uint = 117853008;
      
      internal static const SIG_DATA_DESCRIPTOR:uint = 134695760;
      
      internal static const SIG_ARCHIVE_EXTRA_DATA:uint = 134630224;
      
      internal static const SIG_SPANNING:uint = 134695760;
      
      protected var filesList:Array;
      
      protected var filesDict:Dictionary;
      
      protected var UnknownVarFromFZip_URLStream_1:URLStream;
      
      protected var UnknownVarFromFZip_String_1:String;
      
      protected var UnknownVarFromFZip_Function_1:Function;
      
      protected var currentFile:FZipFile;
      
      protected var UnknownVarFromFZip_ByteArray_1:ByteArray;
      
      protected var UnknownVarFromFZip_Uint_1:uint;
      
      protected var UnknownVarFromFZip_Uint_2:uint;
      
      public function FZip(param1:String = "utf-8")
      {
         super();
         UnknownVarFromFZip_String_1 = param1;
         UnknownVarFromFZip_Function_1 = parseIdle;
      }
      
      public function get active() : Boolean
      {
         return UnknownVarFromFZip_Function_1 !== parseIdle;
      }
      
      public function load(param1:URLRequest) : void
      {
         if(!UnknownVarFromFZip_URLStream_1 && UnknownVarFromFZip_Function_1 == parseIdle)
         {
            UnknownVarFromFZip_URLStream_1 = new URLStream();
            UnknownVarFromFZip_URLStream_1.endian = "littleEndian";
            addEventHandlers();
            filesList = [];
            filesDict = new Dictionary();
            UnknownVarFromFZip_Function_1 = parseSignature;
            UnknownVarFromFZip_URLStream_1.load(param1);
         }
      }
      
      public function loadBytes(param1:ByteArray) : void
      {
         if(!UnknownVarFromFZip_URLStream_1 && UnknownVarFromFZip_Function_1 == parseIdle)
         {
            filesList = [];
            filesDict = new Dictionary();
            param1.position = 0;
            param1.endian = "littleEndian";
            UnknownVarFromFZip_Function_1 = parseSignature;
            if(parse(param1))
            {
               UnknownVarFromFZip_Function_1 = parseIdle;
               dispatchEvent(new Event("complete"));
            }
            else
            {
               dispatchEvent(new FZipErrorEvent("parseError","EOF"));
            }
         }
      }
      
      public function close() : void
      {
         if(UnknownVarFromFZip_URLStream_1)
         {
            UnknownVarFromFZip_Function_1 = parseIdle;
            removeEventHandlers();
            UnknownVarFromFZip_URLStream_1.close();
            UnknownVarFromFZip_URLStream_1 = null;
         }
      }
      
      public function serialize(param1:IDataOutput, param2:Boolean = false) : void
      {
         var _loc7_:String = null;
         var _loc8_:ByteArray = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc3_:FZipFile = null;
         if(param1 != null && filesList.length > 0)
         {
            _loc7_ = param1.endian;
            _loc8_ = new ByteArray();
            param1.endian = _loc8_.endian = "littleEndian";
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < filesList.length)
            {
               _loc3_ = filesList[_loc6_] as FZipFile;
               if(_loc3_ != null)
               {
                  _loc3_.serialize(_loc8_,param2,true,_loc4_);
                  _loc4_ += _loc3_.serialize(param1,param2);
                  _loc5_++;
               }
               _loc6_++;
            }
            if(_loc8_.length > 0)
            {
               param1.writeBytes(_loc8_);
            }
            param1.writeUnsignedInt(101010256);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeShort(_loc5_);
            param1.writeShort(_loc5_);
            param1.writeUnsignedInt(_loc8_.length);
            param1.writeUnsignedInt(_loc4_);
            param1.writeShort(0);
            param1.endian = _loc7_;
         }
      }
      
      public function getFileCount() : uint
      {
         return !!filesList ? filesList.length : 0;
      }
      
      public function getFileAt(param1:uint) : FZipFile
      {
         return !!filesList ? filesList[param1] as FZipFile : null;
      }
      
      public function getFileByName(param1:String) : FZipFile
      {
         return !!filesDict[param1] ? filesDict[param1] as FZipFile : null;
      }
      
      public function addFile(param1:String, param2:ByteArray = null, param3:Boolean = true) : FZipFile
      {
         return addFileAt(!!filesList ? filesList.length : 0,param1,param2,param3);
      }
      
      public function addFileFromString(param1:String, param2:String, param3:String = "utf-8", param4:Boolean = true) : FZipFile
      {
         return addFileFromStringAt(!!filesList ? filesList.length : 0,param1,param2,param3,param4);
      }
      
      public function addFileAt(param1:uint, param2:String, param3:ByteArray = null, param4:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[param2])
         {
            throw new Error("File already exists: " + param2 + ". Please remove first.");
         }
         var _loc5_:FZipFile = new FZipFile();
         _loc5_.filename = param2;
         _loc5_.setContent(param3,param4);
         if(param1 >= filesList.length)
         {
            filesList.push(_loc5_);
         }
         else
         {
            filesList.splice(param1,0,_loc5_);
         }
         filesDict[param2] = _loc5_;
         return _loc5_;
      }
      
      public function addFileFromStringAt(param1:uint, param2:String, param3:String, param4:String = "utf-8", param5:Boolean = true) : FZipFile
      {
         if(filesList == null)
         {
            filesList = [];
         }
         if(filesDict == null)
         {
            filesDict = new Dictionary();
         }
         else if(filesDict[param2])
         {
            throw new Error("File already exists: " + param2 + ". Please remove first.");
         }
         var _loc6_:FZipFile = new FZipFile();
         _loc6_.filename = param2;
         _loc6_.setContentAsString(param3,param4,param5);
         if(param1 >= filesList.length)
         {
            filesList.push(_loc6_);
         }
         else
         {
            filesList.splice(param1,0,_loc6_);
         }
         filesDict[param2] = _loc6_;
         return _loc6_;
      }
      
      public function removeFileAt(param1:uint) : FZipFile
      {
         var _loc2_:FZipFile = null;
         if(filesList != null && filesDict != null && param1 < filesList.length)
         {
            _loc2_ = filesList[param1] as FZipFile;
            if(_loc2_ != null)
            {
               filesList.splice(param1,1);
               delete filesDict[_loc2_.filename];
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function parse(param1:IDataInput) : Boolean
      {
         while(UnknownVarFromFZip_Function_1(param1))
         {
         }
         return UnknownVarFromFZip_Function_1 === parseIdle;
      }
      
      protected function parseIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseSignature(param1:IDataInput) : Boolean
      {
         var _loc2_:* = 0;
         if(param1.bytesAvailable >= 4)
         {
            _loc2_ = uint(param1.readUnsignedInt());
            switch(_loc2_)
            {
               case 67324752:
                  UnknownVarFromFZip_Function_1 = parseLocalfile;
                  currentFile = new FZipFile(UnknownVarFromFZip_String_1);
                  break;
               case 33639248:
               case 101010256:
               case 808471376:
               case 84233040:
               case 101075792:
               case 117853008:
               case 134695760:
               case 134630224:
               case 134695760:
                  UnknownVarFromFZip_Function_1 = parseIdle;
                  break;
               default:
                  throw new Error("Unknown record signature: 0x" + _loc2_.toString(16));
            }
            return true;
         }
         return false;
      }
      
      protected function parseLocalfile(param1:IDataInput) : Boolean
      {
         if(currentFile.parse(param1))
         {
            if(currentFile.hasDataDescriptor)
            {
               UnknownVarFromFZip_Function_1 = findDataDescriptor;
               UnknownVarFromFZip_ByteArray_1 = new ByteArray();
               UnknownVarFromFZip_Uint_1 = 0;
               UnknownVarFromFZip_Uint_2 = 0;
               return true;
            }
            onFileLoaded();
            if(UnknownVarFromFZip_Function_1 != parseIdle)
            {
               UnknownVarFromFZip_Function_1 = parseSignature;
               return true;
            }
         }
         return false;
      }
      
      protected function findDataDescriptor(param1:IDataInput) : Boolean
      {
         var _loc2_:* = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc2_ = uint(param1.readUnsignedByte());
            UnknownVarFromFZip_Uint_1 = UnknownVarFromFZip_Uint_1 >>> 8 | _loc2_ << 24;
            if(UnknownVarFromFZip_Uint_1 == 134695760)
            {
               UnknownVarFromFZip_ByteArray_1.length -= 3;
               UnknownVarFromFZip_Function_1 = validateDataDescriptor;
               return true;
            }
            UnknownVarFromFZip_ByteArray_1.writeByte(_loc2_);
         }
         return false;
      }
      
      protected function validateDataDescriptor(param1:IDataInput) : Boolean
      {
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1.bytesAvailable >= 12)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc2_ = uint(param1.readUnsignedInt());
            _loc3_ = uint(param1.readUnsignedInt());
            if(UnknownVarFromFZip_ByteArray_1.length == _loc2_)
            {
               UnknownVarFromFZip_ByteArray_1.position = 0;
               currentFile._crc32 = _loc4_;
               currentFile._sizeCompressed = _loc2_;
               currentFile._sizeUncompressed = _loc3_;
               currentFile.parseContent(UnknownVarFromFZip_ByteArray_1);
               onFileLoaded();
               UnknownVarFromFZip_Function_1 = parseSignature;
            }
            else
            {
               UnknownVarFromFZip_ByteArray_1.writeUnsignedInt(_loc4_);
               UnknownVarFromFZip_ByteArray_1.writeUnsignedInt(_loc2_);
               UnknownVarFromFZip_ByteArray_1.writeUnsignedInt(_loc3_);
               UnknownVarFromFZip_Function_1 = findDataDescriptor;
            }
            return true;
         }
         return false;
      }
      
      protected function onFileLoaded() : void
      {
         filesList.push(currentFile);
         if(currentFile.filename)
         {
            filesDict[currentFile.filename] = currentFile;
         }
         dispatchEvent(new FZipEvent("fileLoaded",currentFile));
         currentFile = null;
      }
      
      protected function progressHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         dispatchEvent(param1.clone());
         try
         {
            if(parse(UnknownVarFromFZip_URLStream_1))
            {
               close();
               dispatchEvent(new Event("complete"));
            }
         }
         catch(e:Error)
         {
            close();
            if(hasEventListener("parseError"))
            {
               dispatchEvent(new FZipErrorEvent("parseError",e.message));
            }
            else
            {
               _loc2_ = "";
               if(UnknownVarFromFZip_URLStream_1 != null)
               {
                  _loc2_ = UnknownVarFromFZip_URLStream_1.toString();
               }
            }
         }
      }
      
      protected function defaultHandler(param1:Event) : void
      {
         dispatchEvent(param1.clone());
      }
      
      protected function defaultErrorHandler(param1:Event) : void
      {
         close();
         dispatchEvent(param1.clone());
      }
      
      protected function addEventHandlers() : void
      {
         UnknownVarFromFZip_URLStream_1.addEventListener("complete",defaultHandler);
         UnknownVarFromFZip_URLStream_1.addEventListener("open",defaultHandler);
         UnknownVarFromFZip_URLStream_1.addEventListener("httpStatus",defaultHandler);
         UnknownVarFromFZip_URLStream_1.addEventListener("ioError",defaultErrorHandler);
         UnknownVarFromFZip_URLStream_1.addEventListener("securityError",defaultErrorHandler);
         UnknownVarFromFZip_URLStream_1.addEventListener("progress",progressHandler);
      }
      
      protected function removeEventHandlers() : void
      {
         UnknownVarFromFZip_URLStream_1.removeEventListener("complete",defaultHandler);
         UnknownVarFromFZip_URLStream_1.removeEventListener("open",defaultHandler);
         UnknownVarFromFZip_URLStream_1.removeEventListener("httpStatus",defaultHandler);
         UnknownVarFromFZip_URLStream_1.removeEventListener("ioError",defaultErrorHandler);
         UnknownVarFromFZip_URLStream_1.removeEventListener("securityError",defaultErrorHandler);
         UnknownVarFromFZip_URLStream_1.removeEventListener("progress",progressHandler);
      }
   }
}

