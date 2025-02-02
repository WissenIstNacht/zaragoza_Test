import React from 'react';
import {Meta, Story} from '@storybook/react';
import {Wizard, WizardProps} from '../src';

export default {
  title: 'Components/Wizard',
  component: Wizard,
} as Meta;

const Template: Story<WizardProps> = args => <Wizard {...args} />;

export const Default = Template.bind({});
Default.args = {
  processName: 'Deposit Assets',
  currentStep: 1,
  totalSteps: 3,
  title: 'Configure Deposit',
  description:
    'Enter the desired token and its number for transmission. Furthermore, a reception address is necessary.',
};
