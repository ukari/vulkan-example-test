{-# language CPP #-}
module Graphics.Vulkan.Extensions.VK_KHR_external_memory_fd  ( getMemoryFdKHR
                                                             , getMemoryFdPropertiesKHR
                                                             , ImportMemoryFdInfoKHR(..)
                                                             , MemoryFdPropertiesKHR(..)
                                                             , MemoryGetFdInfoKHR(..)
                                                             , KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION
                                                             , pattern KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION
                                                             , KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME
                                                             , pattern KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME
                                                             ) where

import Control.Exception.Base (bracket)
import Foreign.Marshal.Alloc (allocaBytesAligned)
import Foreign.Marshal.Alloc (callocBytes)
import Foreign.Marshal.Alloc (free)
import GHC.Base (when)
import GHC.IO (throwIO)
import Foreign.Ptr (nullPtr)
import Foreign.Ptr (plusPtr)
import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Cont (evalContT)
import Foreign.C.Types (CInt(..))
import Data.String (IsString)
import Data.Typeable (Typeable)
import Foreign.C.Types (CInt)
import Foreign.C.Types (CInt(CInt))
import Foreign.Storable (Storable)
import Foreign.Storable (Storable(peek))
import Foreign.Storable (Storable(poke))
import qualified Foreign.Storable (Storable(..))
import Data.Int (Int32)
import Foreign.Ptr (FunPtr)
import Foreign.Ptr (Ptr)
import Data.Word (Word32)
import Data.Kind (Type)
import Control.Monad.Trans.Cont (ContT(..))
import Graphics.Vulkan.NamedType ((:::))
import Graphics.Vulkan.Core10.Handles (Device)
import Graphics.Vulkan.Core10.Handles (Device(..))
import Graphics.Vulkan.Dynamic (DeviceCmds(pVkGetMemoryFdKHR))
import Graphics.Vulkan.Dynamic (DeviceCmds(pVkGetMemoryFdPropertiesKHR))
import Graphics.Vulkan.Core10.Handles (DeviceMemory)
import Graphics.Vulkan.Core10.Handles (Device_T)
import Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits (ExternalMemoryHandleTypeFlagBits)
import Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits (ExternalMemoryHandleTypeFlagBits(..))
import Graphics.Vulkan.CStruct (FromCStruct)
import Graphics.Vulkan.CStruct (FromCStruct(..))
import Graphics.Vulkan.Core10.Enums.Result (Result)
import Graphics.Vulkan.Core10.Enums.Result (Result(..))
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType)
import Graphics.Vulkan.CStruct (ToCStruct)
import Graphics.Vulkan.CStruct (ToCStruct(..))
import Graphics.Vulkan.Exception (VulkanException(..))
import Graphics.Vulkan.Zero (Zero(..))
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType(STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR))
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType(STRUCTURE_TYPE_MEMORY_FD_PROPERTIES_KHR))
import Graphics.Vulkan.Core10.Enums.StructureType (StructureType(STRUCTURE_TYPE_MEMORY_GET_FD_INFO_KHR))
import Graphics.Vulkan.Core10.Enums.Result (Result(SUCCESS))
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetMemoryFdKHR
  :: FunPtr (Ptr Device_T -> Ptr MemoryGetFdInfoKHR -> Ptr CInt -> IO Result) -> Ptr Device_T -> Ptr MemoryGetFdInfoKHR -> Ptr CInt -> IO Result

-- | vkGetMemoryFdKHR - Get a POSIX file descriptor for a memory object
--
-- = Parameters
--
-- -   'Graphics.Vulkan.Core10.Handles.Device' is the logical device that
--     created the device memory being exported.
--
-- -   @pGetFdInfo@ is a pointer to a 'MemoryGetFdInfoKHR' structure
--     containing parameters of the export operation.
--
-- -   @pFd@ will return a file descriptor representing the underlying
--     resources of the device memory object.
--
-- = Description
--
-- Each call to 'getMemoryFdKHR' /must/ create a new file descriptor and
-- transfer ownership of it to the application. To avoid leaking resources,
-- the application /must/ release ownership of the file descriptor using
-- the @close@ system call when it is no longer needed, or by importing a
-- Vulkan memory object from it. Where supported by the operating system,
-- the implementation /must/ set the file descriptor to be closed
-- automatically when an @execve@ system call is made.
--
-- == Return Codes
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-successcodes Success>]
--
--     -   'Graphics.Vulkan.Core10.Enums.Result.SUCCESS'
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-errorcodes Failure>]
--
--     -   'Graphics.Vulkan.Core10.Enums.Result.ERROR_TOO_MANY_OBJECTS'
--
--     -   'Graphics.Vulkan.Core10.Enums.Result.ERROR_OUT_OF_HOST_MEMORY'
--
-- = See Also
--
-- 'Graphics.Vulkan.Core10.Handles.Device', 'MemoryGetFdInfoKHR'
getMemoryFdKHR :: Device -> MemoryGetFdInfoKHR -> IO (("fd" ::: Int32))
getMemoryFdKHR device getFdInfo = evalContT $ do
  let vkGetMemoryFdKHR' = mkVkGetMemoryFdKHR (pVkGetMemoryFdKHR (deviceCmds (device :: Device)))
  pGetFdInfo <- ContT $ withCStruct (getFdInfo)
  pPFd <- ContT $ bracket (callocBytes @CInt 4) free
  r <- lift $ vkGetMemoryFdKHR' (deviceHandle (device)) pGetFdInfo (pPFd)
  lift $ when (r < SUCCESS) (throwIO (VulkanException r))
  pFd <- lift $ peek @CInt pPFd
  pure $ (((\(CInt a) -> a) pFd))


foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "dynamic" mkVkGetMemoryFdPropertiesKHR
  :: FunPtr (Ptr Device_T -> ExternalMemoryHandleTypeFlagBits -> CInt -> Ptr MemoryFdPropertiesKHR -> IO Result) -> Ptr Device_T -> ExternalMemoryHandleTypeFlagBits -> CInt -> Ptr MemoryFdPropertiesKHR -> IO Result

-- | vkGetMemoryFdPropertiesKHR - Get Properties of External Memory File
-- Descriptors
--
-- = Parameters
--
-- -   'Graphics.Vulkan.Core10.Handles.Device' is the logical device that
--     will be importing @fd@.
--
-- -   @handleType@ is the type of the handle @fd@.
--
-- -   @fd@ is the handle which will be imported.
--
-- -   @pMemoryFdProperties@ is a pointer to a 'MemoryFdPropertiesKHR'
--     structure in which the properties of the handle @fd@ are returned.
--
-- == Return Codes
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-successcodes Success>]
--
--     -   'Graphics.Vulkan.Core10.Enums.Result.SUCCESS'
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#fundamentals-errorcodes Failure>]
--
--     -   'Graphics.Vulkan.Core10.Enums.Result.ERROR_INVALID_EXTERNAL_HANDLE'
--
-- = See Also
--
-- 'Graphics.Vulkan.Core10.Handles.Device',
-- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits',
-- 'MemoryFdPropertiesKHR'
getMemoryFdPropertiesKHR :: Device -> ExternalMemoryHandleTypeFlagBits -> ("fd" ::: Int32) -> IO (MemoryFdPropertiesKHR)
getMemoryFdPropertiesKHR device handleType fd = evalContT $ do
  let vkGetMemoryFdPropertiesKHR' = mkVkGetMemoryFdPropertiesKHR (pVkGetMemoryFdPropertiesKHR (deviceCmds (device :: Device)))
  pPMemoryFdProperties <- ContT (withZeroCStruct @MemoryFdPropertiesKHR)
  r <- lift $ vkGetMemoryFdPropertiesKHR' (deviceHandle (device)) (handleType) (CInt (fd)) (pPMemoryFdProperties)
  lift $ when (r < SUCCESS) (throwIO (VulkanException r))
  pMemoryFdProperties <- lift $ peekCStruct @MemoryFdPropertiesKHR pPMemoryFdProperties
  pure $ (pMemoryFdProperties)


-- | VkImportMemoryFdInfoKHR - import memory created on the same physical
-- device from a file descriptor
--
-- = Description
--
-- Importing memory from a file descriptor transfers ownership of the file
-- descriptor from the application to the Vulkan implementation. The
-- application /must/ not perform any operations on the file descriptor
-- after a successful import.
--
-- Applications /can/ import the same underlying memory into multiple
-- instances of Vulkan, into the same instance from which it was exported,
-- and multiple times into a given Vulkan instance. In all cases, each
-- import operation /must/ create a distinct
-- 'Graphics.Vulkan.Core10.Handles.DeviceMemory' object.
--
-- == Valid Usage
--
-- -   If @handleType@ is not @0@, it /must/ be supported for import, as
--     reported by
--     'Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities.ExternalImageFormatProperties'
--     or
--     'Graphics.Vulkan.Core11.Promoted_From_VK_KHR_external_memory_capabilities.ExternalBufferProperties'.
--
-- -   The memory from which @fd@ was exported /must/ have been created on
--     the same underlying physical device as
--     'Graphics.Vulkan.Core10.Handles.Device'.
--
-- -   If @handleType@ is not @0@, it /must/ be defined as a POSIX file
--     descriptor handle.
--
-- -   If @handleType@ is not @0@, @fd@ /must/ be a valid handle of the
--     type specified by @handleType@.
--
-- -   The memory represented by @fd@ /must/ have been created from a
--     physical device and driver that is compatible with
--     'Graphics.Vulkan.Core10.Handles.Device' and @handleType@, as
--     described in
--     <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#external-memory-handle-types-compatibility>.
--
-- -   @fd@ /must/ obey any requirements listed for @handleType@ in
--     <https://www.khronos.org/registry/vulkan/specs/1.2-extensions/html/vkspec.html#external-memory-handle-types-compatibility external memory handle types compatibility>.
--
-- == Valid Usage (Implicit)
--
-- -   @sType@ /must/ be
--     'Graphics.Vulkan.Core10.Enums.StructureType.STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR'
--
-- -   If @handleType@ is not @0@, @handleType@ /must/ be a valid
--     'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits'
--     value
--
-- = See Also
--
-- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits',
-- 'Graphics.Vulkan.Core10.Enums.StructureType.StructureType'
data ImportMemoryFdInfoKHR = ImportMemoryFdInfoKHR
  { -- | @handleType@ specifies the handle type of @fd@.
    handleType :: ExternalMemoryHandleTypeFlagBits
  , -- | @fd@ is the external handle to import.
    fd :: Int32
  }
  deriving (Typeable)
deriving instance Show ImportMemoryFdInfoKHR

instance ToCStruct ImportMemoryFdInfoKHR where
  withCStruct x f = allocaBytesAligned 24 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p ImportMemoryFdInfoKHR{..} f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 16 :: Ptr ExternalMemoryHandleTypeFlagBits)) (handleType)
    poke ((p `plusPtr` 20 :: Ptr CInt)) (CInt (fd))
    f
  cStructSize = 24
  cStructAlignment = 8
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_IMPORT_MEMORY_FD_INFO_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 20 :: Ptr CInt)) (CInt (zero))
    f

instance FromCStruct ImportMemoryFdInfoKHR where
  peekCStruct p = do
    handleType <- peek @ExternalMemoryHandleTypeFlagBits ((p `plusPtr` 16 :: Ptr ExternalMemoryHandleTypeFlagBits))
    fd <- peek @CInt ((p `plusPtr` 20 :: Ptr CInt))
    pure $ ImportMemoryFdInfoKHR
             handleType ((\(CInt a) -> a) fd)

instance Storable ImportMemoryFdInfoKHR where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero ImportMemoryFdInfoKHR where
  zero = ImportMemoryFdInfoKHR
           zero
           zero


-- | VkMemoryFdPropertiesKHR - Properties of External Memory File Descriptors
--
-- == Valid Usage (Implicit)
--
-- = See Also
--
-- 'Graphics.Vulkan.Core10.Enums.StructureType.StructureType',
-- 'getMemoryFdPropertiesKHR'
data MemoryFdPropertiesKHR = MemoryFdPropertiesKHR
  { -- | @memoryTypeBits@ is a bitmask containing one bit set for every memory
    -- type which the specified file descriptor /can/ be imported as.
    memoryTypeBits :: Word32 }
  deriving (Typeable)
deriving instance Show MemoryFdPropertiesKHR

instance ToCStruct MemoryFdPropertiesKHR where
  withCStruct x f = allocaBytesAligned 24 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p MemoryFdPropertiesKHR{..} f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_MEMORY_FD_PROPERTIES_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 16 :: Ptr Word32)) (memoryTypeBits)
    f
  cStructSize = 24
  cStructAlignment = 8
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_MEMORY_FD_PROPERTIES_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 16 :: Ptr Word32)) (zero)
    f

instance FromCStruct MemoryFdPropertiesKHR where
  peekCStruct p = do
    memoryTypeBits <- peek @Word32 ((p `plusPtr` 16 :: Ptr Word32))
    pure $ MemoryFdPropertiesKHR
             memoryTypeBits

instance Storable MemoryFdPropertiesKHR where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero MemoryFdPropertiesKHR where
  zero = MemoryFdPropertiesKHR
           zero


-- | VkMemoryGetFdInfoKHR - Structure describing a POSIX FD semaphore export
-- operation
--
-- = Description
--
-- The properties of the file descriptor exported depend on the value of
-- @handleType@. See
-- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits'
-- for a description of the properties of the defined external memory
-- handle types.
--
-- Note
--
-- The size of the exported file /may/ be larger than the size requested by
-- 'Graphics.Vulkan.Core10.Memory.MemoryAllocateInfo'::allocationSize. If
-- @handleType@ is
-- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.EXTERNAL_MEMORY_HANDLE_TYPE_DMA_BUF_BIT_EXT',
-- then the application /can/ query the file’s actual size with
-- <man:lseek(2) lseek(2)>.
--
-- == Valid Usage (Implicit)
--
-- = See Also
--
-- 'Graphics.Vulkan.Core10.Handles.DeviceMemory',
-- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits',
-- 'Graphics.Vulkan.Core10.Enums.StructureType.StructureType',
-- 'getMemoryFdKHR'
data MemoryGetFdInfoKHR = MemoryGetFdInfoKHR
  { -- | @memory@ /must/ be a valid 'Graphics.Vulkan.Core10.Handles.DeviceMemory'
    -- handle
    memory :: DeviceMemory
  , -- | @handleType@ /must/ be a valid
    -- 'Graphics.Vulkan.Core11.Enums.ExternalMemoryHandleTypeFlagBits.ExternalMemoryHandleTypeFlagBits'
    -- value
    handleType :: ExternalMemoryHandleTypeFlagBits
  }
  deriving (Typeable)
deriving instance Show MemoryGetFdInfoKHR

instance ToCStruct MemoryGetFdInfoKHR where
  withCStruct x f = allocaBytesAligned 32 8 $ \p -> pokeCStruct p x (f p)
  pokeCStruct p MemoryGetFdInfoKHR{..} f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_MEMORY_GET_FD_INFO_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 16 :: Ptr DeviceMemory)) (memory)
    poke ((p `plusPtr` 24 :: Ptr ExternalMemoryHandleTypeFlagBits)) (handleType)
    f
  cStructSize = 32
  cStructAlignment = 8
  pokeZeroCStruct p f = do
    poke ((p `plusPtr` 0 :: Ptr StructureType)) (STRUCTURE_TYPE_MEMORY_GET_FD_INFO_KHR)
    poke ((p `plusPtr` 8 :: Ptr (Ptr ()))) (nullPtr)
    poke ((p `plusPtr` 16 :: Ptr DeviceMemory)) (zero)
    poke ((p `plusPtr` 24 :: Ptr ExternalMemoryHandleTypeFlagBits)) (zero)
    f

instance FromCStruct MemoryGetFdInfoKHR where
  peekCStruct p = do
    memory <- peek @DeviceMemory ((p `plusPtr` 16 :: Ptr DeviceMemory))
    handleType <- peek @ExternalMemoryHandleTypeFlagBits ((p `plusPtr` 24 :: Ptr ExternalMemoryHandleTypeFlagBits))
    pure $ MemoryGetFdInfoKHR
             memory handleType

instance Storable MemoryGetFdInfoKHR where
  sizeOf ~_ = 32
  alignment ~_ = 8
  peek = peekCStruct
  poke ptr poked = pokeCStruct ptr poked (pure ())

instance Zero MemoryGetFdInfoKHR where
  zero = MemoryGetFdInfoKHR
           zero
           zero


type KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION = 1

-- No documentation found for TopLevel "VK_KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION"
pattern KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION :: forall a . Integral a => a
pattern KHR_EXTERNAL_MEMORY_FD_SPEC_VERSION = 1


type KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME = "VK_KHR_external_memory_fd"

-- No documentation found for TopLevel "VK_KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME"
pattern KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME :: forall a . (Eq a, IsString a) => a
pattern KHR_EXTERNAL_MEMORY_FD_EXTENSION_NAME = "VK_KHR_external_memory_fd"

