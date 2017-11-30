class Service
  class ServiceBlueprint
    class Capabilities < ::Blueprint::Section

      attr_accessor :allow,
                    :selected

      def build_section
        @allow = ( ( data || {} ).dig :allow ) || :default
        @selected = ( ( data || {} ).dig :selected ) || [
          "SETPCAP",
          "MKNOD",
          "AUDIT_WRITE",
          "CHOWN",
          "NET_RAW",
          "DAC_OVERRIDE",
          "FOWNER",
          "FSETID",
          "KILL",
          "SETGID",
          "SETUID",
          "NET_BIND_SERVICE",
          "SYS_CHROOT",
          "SETFCAP",
        ]
        # byebug

      end

      def form_data
        {
          allow: allow,
          selected: selected
        }
      end

      def allow_selected_collection
        [
          [ "SETPCAP - Modify process capabilities.", "SETPCAP" ],
          [ "MKNOD - Create special files using mknod(2).", "MKNOD" ],
          [ "AUDIT_WRITE - Write records to kernel auditing log.", "AUDIT_WRITE" ],
          [ "CHOWN - Make arbitrary changes to file UIDs and GIDs (see chown(2)).", "CHOWN" ],
          [ "NET_RAW - Use RAW and PACKET sockets.", "NET_RAW" ],
          [ "DAC_OVERRIDE - Bypass file read, write, and execute permission checks.", "DAC_OVERRIDE" ],
          [ "FOWNER - Bypass permission checks on operations that normally require the file system UID of the process to match the UID of the file.", "FOWNER" ],
          [ "FSETID - Don’t clear set-user-ID and set-group-ID permission bits when a file is modified.", "FSETID" ],
          [ "KILL - Bypass permission checks for sending signals.", "KILL" ],
          [ "SETGID - Make arbitrary manipulations of process GIDs and supplementary GID list.", "SETGID" ],
          [ "SETUID - Make arbitrary manipulations of process UIDs.", "SETUID" ],
          [ "NET_BIND_SERVICE - Bind a socket to internet domain privileged ports (port numbers less than 1024).", "NET_BIND_SERVICE" ],
          [ "SYS_CHROOT - Use chroot(2), change root directory.", "SYS_CHROOT" ],
          [ "SETFCAP - Set file capabilities.", "SETFCAP" ],
          [ "SYS_MODULE - Load and unload kernel modules.", "SYS_MODULE" ],
          [ "SYS_RAWIO - Perform I/O port operations (iopl(2) and ioperm(2)).", "SYS_RAWIO" ],
          [ "SYS_PACCT - Use acct(2), switch process accounting on or off.", "SYS_PACCT" ],
          [ "SYS_ADMIN - Perform a range of system administration operations.", "SYS_ADMIN" ],
          [ "SYS_NICE - Raise process nice value (nice(2), setpriority(2)) and change the nice value for arbitrary processes.", "SYS_NICE" ],
          [ "SYS_RESOURCE - Override resource Limits.", "SYS_RESOURCE" ],
          [ "SYS_TIME - Set system clock (settimeofday(2), stime(2), adjtimex(2)); set real-time (hardware) clock.", "SYS_TIME" ],
          [ "SYS_TTY_CONFIG - Use vhangup(2); employ various privileged ioctl(2) operations on virtual terminals.", "SYS_TTY_CONFIG" ],
          [ "AUDIT_CONTROL - Enable and disable kernel auditing; change auditing filter rules; retrieve auditing status and filtering rules.", "AUDIT_CONTROL" ],
          [ "MAC_OVERRIDE - Allow MAC configuration or state changes. Implemented for the Smack LSM.", "MAC_OVERRIDE" ],
          [ "MAC_ADMIN - Override Mandatory Access Control (MAC). Implemented for the Smack Linux Security Module (LSM).", "MAC_ADMIN" ],
          [ "NET_ADMIN - Perform various network-related operations.", "NET_ADMIN" ],
          [ "SYSLOG - Perform privileged syslog(2) operations.", "SYSLOG" ],
          [ "DAC_READ_SEARCH - Bypass file read permission checks and directory read and execute permission checks.", "DAC_READ_SEARCH" ],
          [ "LINUX_IMMUTABLE - Set the FS_APPEND_FL and FS_IMMUTABLE_FL i-node flags.", "LINUX_IMMUTABLE" ],
          [ "NET_BROADCAST - Make socket broadcasts, and listen to multicasts.", "NET_BROADCAST" ],
          [ "IPC_LOCK - Lock memory (mlock(2), mlockall(2), mmap(2), shmctl(2)).", "IPC_LOCK" ],
          [ "IPC_OWNER - Bypass permission checks for operations on System V IPC objects.", "IPC_OWNER" ],
          [ "SYS_PTRACE - Trace arbitrary processes using ptrace(2).", "SYS_PTRACE" ],
          [ "SYS_BOOT - Use reboot(2) and kexec_load(2), reboot and load a new kernel for later execution.", "SYS_BOOT" ],
          [ "LEASE - Establish leases on arbitrary files (see fcntl(2)).", "LEASE" ],
          [ "WAKE_ALARM - Trigger something that will wake up the system.", "WAKE_ALARM" ],
          [ "BLOCK_SUSPEND - Employ features that can block system suspend.", "BLOCK_SUSPEND" ],
        ]
      end

    end
  end
end
