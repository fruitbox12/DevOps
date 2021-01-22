       private void UpdatePhoneNumber(int contactId)
        {
            ResultSet<List<PhoneNumberModel>> phoneNumberModels;
            bool finished = false;

            string input = "";
            string phoneNumber = "";

            phoneNumberModels = _contacts.GetEmailAddresses(contactId);

            if (phoneNumberModels.Result.Count > 0)
            {

                foreach (PhoneNumberModel phoneNumberModel in phoneNumberModels.Result)
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine(phoneNumberModel.PhoneNumber);
                    Console.ResetColor();
                    finished = false;

                    while (!finished)
                    {

                        Console.ForegroundColor = ConsoleColor.Green;

                        Console.Write("Enter a new email address or Press enter to exit or Press Spacebar Enter To Delete:\n");
                        Console.ResetColor();

                        phoneNumber = Console.ReadLine();

                        int emailId = phoneNumberModel.Id;
                        if (phoneNumber.Length > 0)
                        {
                            phoneNumber = phoneNumber.Trim();

                            if (phoneNumber.Length > 0)
                            {

                                if (Tools.ValidateEmailAddressCharacters(phoneNumber))
                                {
                                    if (Tools.ValidateEmailAddressFormat(phoneNumber))
                                    {
                                        string prevEmail = phoneNumberModel.PhoneNumber;

                                        phoneNumberModel.PhoneNumber = phoneNumber;

                                        ResultSet<EmailAddressModel> resultSet = _contacts.UpdateEmailAddress(phoneNumberModel);
                                        if (resultSet.LogicalError || resultSet.CriticalError)
                                        {
                                            DisplayErrors(resultSet);
                                        }
                                        else
                                        {
                                            Console.ForegroundColor = ConsoleColor.Green;
                                            Console.WriteLine("Email Address: " + prevEmail + " Successfully Updated To: " + "[" + emailAddress + "]");
                                            Console.ResetColor();
                                        }

                                        finished = true;

                                    }
                                    else
                                    {
                                        Console.ForegroundColor = ConsoleColor.Red;
                                        Console.WriteLine(Tools.InvalidEmailFormat);
                                        Console.ResetColor();
                                    }
                                }
                                else
                                {
                                    Console.ForegroundColor = ConsoleColor.Red;

                                    Console.WriteLine(Tools.InvalidEmailCharacter);
                                    Console.ResetColor();

                                }
                            }
                            else
                            {
                                ResultSet<int> delete = _contacts.DeleteEmailAddress(emailId, contactId);
                                if (delete.Result > 0)
                                {
                                    Console.ForegroundColor = ConsoleColor.Green;

                                    Console.WriteLine("Email Address With Id: " + emailId + " Was Successfully Deleted");
                                    Console.ResetColor();
                                }
                                else
                                {
                                    DisplayErrors(delete);
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine("Email Address Was Not Updated");
                            finished = true;

                            Console.WriteLine();
                        }
                    }
                }
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Green;

                Console.WriteLine("No Current Email Addresses Found");
                Console.WriteLine("Adding email addresses");
                Console.ResetColor();

                AddEmailAddress(contactId);
                finished = true;

            }
            AddEmailAddress(contactId);
            finished = true;

        }